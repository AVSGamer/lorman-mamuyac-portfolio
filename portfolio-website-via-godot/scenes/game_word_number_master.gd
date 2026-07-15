extends Node2D

# Global Signals
signal game_over
signal input_checked(is_match: bool, digit_count: int)

# Game Variables
@export var starting_time: float = 60.0
@export var difficulty_scale_rate: float = 0.05 # How much speed increases every 10 seconds

var current_time: float = 0.0
var score: int = 0
var speed_modifier: float = 1.0
var game_active: bool = true
var viewport_based_division: int = 0

@onready var timer_label: Label = $GameUI/Control/MarginContainer/VBoxContainer/TopBar/TimerLabel
@onready var score_label: Label = $GameUI/Control/MarginContainer/VBoxContainer/TopBar/ScoreLabel
@onready var game_board: Node2D = $GameBoard
@onready var typing_input: LineEdit = $GameUI/Control/MarginContainer/VBoxContainer/InputBar/TypingInput
@onready var feedback_effects: Node = $FeedbackEffects
@onready var spawn_marker_root: Node2D = $GameBoard/SpawnPositions

func _ready() -> void:
	current_time = starting_time
	score = 0
	speed_modifier = 1.0
	game_active = true

	viewport_based_division = get_viewport_rect().size.x / 6
	var local_counter: int = 1
	for sp_markers in spawn_marker_root.get_children():
		sp_markers.set("position", Vector2(viewport_based_division*local_counter,0))
		local_counter+=1
	
	# Connect local signals
	input_checked.connect(_on_input_checked)
	typing_input.text_submitted.connect(_on_text_submitted)
	
	# Setup UI and give focus to input box immediately
	typing_input.grab_focus()
	
	# Enforce engine to adapt beautifully to modern high DPI viewports
	get_window().content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
	get_window().content_scale_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND
	
	# Hook code into our newly added generator architecture
	if has_node("AudioPlayers"):
		$AudioPlayers.set_script(preload("res://scenes/AudioGenerator.gd"))
		
	# Previous initialization sequences from Phase 3 stay intact below...
	typing_input.text_submitted.connect(_on_text_submitted)
	typing_input.grab_focus()

func _process(delta: float) -> void:
	if not game_active:
		return
		
	# 1. Handle Game Countdown Timer
	current_time -= delta
	if current_time <= 0.0:
		current_time = 0.0
		_trigger_game_over()
	_update_timer_display()
	
	# 2. Smoothly scale difficulty modifier over time
	speed_modifier += difficulty_scale_rate * delta

func _update_timer_display() -> void:
	timer_label.text = "TIME: %d" % ceil(current_time)

func _update_score_display() -> void:
	score_label.text = "SCORE: %d" % score

func _on_input_checked(is_match: bool, digit_count: int) -> void:
	if is_match:
		# Add score based on digits completed
		score += digit_count * 10
		_update_score_display()
		
		# Extend timer proportionally to correct answer digit length (e.g., 1.5 seconds per digit)
		current_time += digit_count * 1.5
		$AudioPlayers/SuccessSound.play()
	else:
		# Trigger audio feedback for error
		$AudioPlayers/ErrorSound.play()

func _trigger_game_over() -> void:
	game_active = false
	emit_signal("game_over")
	typing_input.editable = false
	#Call modal to show GameOver
	print("Game Over triggered! Final Score: ", score)

func _on_text_submitted(submitted_text: String) -> void:
	if not game_active:
		return
		
	# 1. Sanitize text string explicitly via a Regular Expression engine matching only 0-9
	var regex = RegEx.new()
	regex.compile("[^0-9]") # Target anything that is NOT a digit
	var sanitized_text = regex.sub(submitted_text, "", true)
	
	# Clear field text UI immediately for subsequent rapid-fire attempts
	typing_input.clear()
	
	if sanitized_text.is_empty():
		_trigger_incorrect_state()
		return
		
	# 2. Check game board list arrays for active element target matches
	var match_found: bool = false
	var matching_digit_count: int = 0
	
	# Iterate over copy array sequence to prevent mutating indices safely during inline deletions
	var targets_to_evaluate = game_board.active_elements.duplicate()
	
	for element in targets_to_evaluate:
		if is_instance_valid(element) and element.target_number == sanitized_text:
			match_found = true
			matching_digit_count = sanitized_text.length()
			
			# Eliminate match instance cleanly from viewport space
			element.queue_free()
			
	# 3. Emit structural feedback routing signals across game branches
	if match_found:
		emit_signal("input_checked", true, matching_digit_count)
	else:
		_trigger_incorrect_state()

func _trigger_incorrect_state() -> void:
	emit_signal("input_checked", false, 0)
	if feedback_effects.has_method("trigger_error_feedback"):
		feedback_effects.trigger_error_feedback()
