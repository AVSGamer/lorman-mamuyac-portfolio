extends Node2D

# Global Signals
signal game_over
signal input_checked(is_match: bool, digit_count: int)
signal return_to_menu

# Game Variables
@export var starting_time: float = 60.0
@export var difficulty_scale_rate: float = 0.05 # How much speed increases every 10 seconds

var current_time: float = 0.0
var score: int = 0
var speed_modifier: float = 1.0
var game_active: bool = false
var viewport_based_division: int = 0
var total_timer: int = 0

@onready var timer_label: Label = $GameUI/Control/MarginContainer/VBoxContainer/TopBar/TimerLabel
@onready var score_label: Label = $GameUI/Control/MarginContainer/VBoxContainer/TopBar/ScoreLabel
@onready var play_again_lbl: Label = $GameEndModal/Control/AspectRatioContainer/MarginContainer/MarginContainer/VBoxContainer/lbl_PlayAgain
@onready var submit_status: Label = $GameEndModal/Control/AspectRatioContainer/MarginContainer/MarginContainer/VBoxContainer/lbl_SubmissionStatus
@onready var game_board: Node2D = $GameBoard
@onready var spawn_marker_root: Node2D = $GameBoard/SpawnPositions
@onready var typing_input: LineEdit = $GameUI/Control/MarginContainer/VBoxContainer/InputBar/TypingInput
@onready var player_name_leaderboard: LineEdit = $GameEndModal/Control/AspectRatioContainer/MarginContainer/MarginContainer/VBoxContainer/ledt_PlayerName
@onready var feedback_effects: Node = $FeedbackEffects
@onready var submit_button: Button = $GameEndModal/Control/AspectRatioContainer/MarginContainer/MarginContainer/VBoxContainer/btn_SubmitScore
@onready var play_again_HBox: HBoxContainer = $GameEndModal/Control/AspectRatioContainer/MarginContainer/MarginContainer/VBoxContainer/HBoxContainer2
@onready var game_end_modal_total_time: Label = $GameEndModal/Control/AspectRatioContainer/MarginContainer/MarginContainer/VBoxContainer/lbl_TTimeSurvdVal
@onready var game_end_score: Label = $GameEndModal/Control/AspectRatioContainer/MarginContainer/MarginContainer/VBoxContainer/lbl_TScoreVal

func _ready() -> void:
	$%btn_OwnVirtualKeyb.toggle_mode = true
	$%btn_VirtualKeyb.toggle_mode = true
	# Hook code into our newly added generator architecture
	if has_node("AudioPlayers"):
		$AudioPlayers.set_script(preload("res://scenes/AudioGenerator.gd"))
		
	# Connect local signals
	input_checked.connect(_on_input_checked)
	typing_input.text_submitted.connect(_on_text_submitted)
		
	# Enforce engine to adapt beautifully to modern high DPI viewports		
	get_window().content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
	get_window().content_scale_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND

func _process(delta: float) -> void:
	if not game_active:
		return
	else:
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
		total_timer += digit_count * 1.5
		$AudioPlayers/SuccessSound.play()
		typing_input.grab_focus()
	else:
		# Trigger audio feedback for error
		$AudioPlayers/ErrorSound.play()
		typing_input.grab_focus()

func _trigger_game_over() -> void:
	game_active = false
	emit_signal("game_over")
	typing_input.editable = false
	#Call modal to show GameOver
	game_end_score.text = str(score)
	game_end_modal_total_time.text = str(total_timer)
	$GameEndModal.visible = true
	
func _on_text_submitted(submitted_text: String) -> void:
	if not game_active:
		return
		
	# 1. Sanitize text string explicitly via a Regular Expression engine matching only 0-9
	var regex = RegEx.new()
	regex.compile("[^0-9]") # Target anything that is NOT a digit
	var sanitized_text = regex.sub(submitted_text, "", true)
	
	# Clear field text UI immediately for subsequent rapid-fire attempts
	typing_input.clear()
	typing_input.grab_focus()
	
	if sanitized_text.is_empty():
		_trigger_incorrect_state()
		typing_input.grab_focus()
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

func _on_btn_submit_y_button_up() -> void:
	player_name_leaderboard.visible = true
	submit_button.visible = true
	submit_button.disabled = true
	play_again_HBox.visible = true

func _on_btn_submit_n_button_up() -> void:
	player_name_leaderboard.visible = false
	submit_button.visible = false
	play_again_lbl.visible = true
	play_again_HBox.visible = true

func _on_btn_submit_score_button_up() -> void:
	submit_status.visible = true
	#call api to store score and wait for a returned success or failed value
	#show that status in the label above
	#regardless show the Play Again Prompts
	play_again_lbl.visbile = true
	play_again_HBox.visible = true

func _on_ledt_player_name_text_changed(new_text: String) -> void:
	#use regex to filter/match what's inputted
	#if a match is found then do not enable the submit button
	#$GameEndModal/Control/AspectRatioContainer/MarginContainer/MarginContainer/VBoxContainer/btn_SubmitScore.disabled = false
	pass

func _on_btn_again_y_button_up() -> void:
	player_name_leaderboard.visible = false
	submit_button.visible = false
	submit_status.visible = false
	play_again_lbl.visible = false
	play_again_HBox.visible = false
	$GameEndModal.visible = false
	typing_input.editable = true
	#restart the game
	self._start_game()

func _on_btn_again_n_button_up() -> void:
	emit_signal('return_to_menu')

func _start_game() -> void:
	current_time = starting_time
	total_timer = starting_time
	score = 0
	speed_modifier = 1.0
	game_active = true

	_update_score_display()
	viewport_based_division = get_viewport_rect().size.x / 6
	var local_counter: int = 1
	for sp_markers in spawn_marker_root.get_children():
		sp_markers.set("position", Vector2(viewport_based_division*local_counter,0))
		local_counter+=1
	
	# Setup UI and give focus to input box immediately
	typing_input.editable = true
	typing_input.grab_focus()	

func _on_btn_start_gy_button_up() -> void:
	$%SettingsModal.hide()
	$GameEndModal.hide()
	_start_game()

func _on_btn_start_gn_button_up() -> void:
	emit_signal('return_to_menu')

func _on_btn_exit_button_button_up() -> void:
	emit_signal('return_to_menu')

func _on_btn_show_exit_btn_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		$%btn_ExitButton.show()
	else:
		$%btn_ExitButton.hide()

func _on_btn_virtual_keyb_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		$%btn_OwnVirtualKeyb.button_pressed = false
		$%gc_VKeyb.show()
	else:
		$%gc_VKeyb.hide()

func _on_btn_own_virtual_keyb_toggled(toggled_on: bool) -> void:
	typing_input.virtual_keyboard_enabled = toggled_on
	if toggled_on == true:
		$%btn_VirtualKeyb.button_pressed = false
		
func _on_btn_1_button_up() -> void:
	typing_input.insert_text_at_caret('1')
	typing_input.grab_focus()

func _on_btn_2_button_up() -> void:
	typing_input.insert_text_at_caret('2')
	typing_input.grab_focus()

func _on_btn_3_button_up() -> void:
	typing_input.insert_text_at_caret('3')
	typing_input.grab_focus()
	
func _on_btn_4_button_up() -> void:
	typing_input.insert_text_at_caret('4')
	typing_input.grab_focus()

func _on_btn_5_button_up() -> void:
	typing_input.insert_text_at_caret('5')
	typing_input.grab_focus()
	
func _on_btn_6_button_up() -> void:
	typing_input.insert_text_at_caret('6')
	typing_input.grab_focus()
	
func _on_btn_7_button_up() -> void:
	typing_input.insert_text_at_caret('7')
	typing_input.grab_focus()
	
func _on_btn_8_button_up() -> void:
	typing_input.insert_text_at_caret('8')
	typing_input.grab_focus()
	
func _on_btn_9_button_up() -> void:
	typing_input.insert_text_at_caret('9')
	typing_input.grab_focus()

func _on_btn_0_button_up() -> void:
	typing_input.insert_text_at_caret('0')
	typing_input.grab_focus()

func _on_btn_send_button_up() -> void:
	_on_text_submitted(typing_input.text)
	typing_input.grab_focus()

func _on_btn_backspace_button_up() -> void:
	typing_input.delete_char_at_caret()
	typing_input.grab_focus()

func _on_btn_settings_page_button_up() -> void:
	$%SettingsModal.show()
