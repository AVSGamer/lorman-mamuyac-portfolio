extends Node2D

@export var falling_element_scene: PackedScene = preload("res://scenes/FallingElement.tscn")
@export var spawn_cooldown_base: float = 3.5 # Spawns a piece every 3.5 seconds basline

var spawn_timer: float = 0.0
var active_elements: Array[FallingElement] = []
var userSetFontSize: int = 24
var userSetFont: Font = preload("res://assets/fonts/data-control/data-latin.ttf")
var fallDirection: int = 0
var gameVariant:int = 0

@onready var main_root: Node = get_parent()
@onready var spawn_positions: Node2D = $SpawnPositions

func _ready() -> void:
	main_root.fallingElementChanged.connect(_on_falling_element_changed)

func _on_falling_element_changed(size: int, font: Font, fD: int, gV: int) -> void:
	userSetFontSize = size
	userSetFont = font
	fallDirection = fD
	gameVariant = gV

func _process(delta: float) -> void:
	if not main_root.game_active:
		return
		
	# Process spawning timeline
	spawn_timer -= delta
	if spawn_timer <= 0.0:
		_spawn_random_element()
		# Dynamic scaling: higher speed values decrease the cooldown gap between spawns
		spawn_timer = max(1.0, spawn_cooldown_base / main_root.speed_modifier)

func _spawn_random_element() -> void:
	var markers = spawn_positions.get_children()
	var extras
	if markers.is_empty():
		return
	match fallDirection:
		0:
			extras = markers.slice(0,5)
		1:
			extras = markers.slice(5,9)
		2:
			extras = markers.slice(9)
		_:
			extras = markers
	
	var chosen_marker: Marker2D = extras[randi() % extras.size()]
	
	# Determine difficulty tier based on current game speed modifier
	# Modifier starts at 1.0 and goes up. Every 0.5 step unlocks a higher digit tier.
	var current_modifier = main_root.speed_modifier
	var difficulty_tier: int = 1
	if current_modifier > 2.5:
		difficulty_tier = 4 # Thousands tier unlocked
	elif current_modifier > 1.8:
		difficulty_tier = 3 # Hundreds tier unlocked
	elif current_modifier > 1.3:
		difficulty_tier = 2 # Double digits unlocked

	# Procedurally generate our word/number asset combo
	var dynamic_data = NumberParser.generate_pair(difficulty_tier)
	
	# Instantiate element node into the game world branch
	var element_instance: FallingElement = falling_element_scene.instantiate() as FallingElement
	element_instance.init(userSetFontSize, userSetFont, fallDirection, gameVariant)
	
	match gameVariant:
		0:
			element_instance.word_text = dynamic_data["word"]
			element_instance.target_number = dynamic_data["num"]
		1:
			element_instance.word_text = dynamic_data["word"]
			element_instance.target_number = dynamic_data["num"]
		2:
			element_instance.word_text = dynamic_data["num"]
			element_instance.target_number = dynamic_data["num"]
		3:
			element_instance.word_text = dynamic_data["num"]
			element_instance.target_number = dynamic_data["num"]
		4:
			if randi() % 2 == 0:
				element_instance.word_text = dynamic_data["word"]
				element_instance.target_number = dynamic_data["num"]
			else:
				element_instance.word_text = dynamic_data["num"]
				element_instance.target_number = dynamic_data["num"]
		5:
			if randi() % 2 == 0:
				element_instance.word_text = dynamic_data["word"]
				element_instance.target_number = dynamic_data["num"]
			else:
				element_instance.word_text = dynamic_data["num"]
				element_instance.target_number = dynamic_data["num"]
	
	# Elements fall faster as game progresses
	element_instance.speed_modifier = current_modifier
	element_instance.position = chosen_marker.position
	
	add_child(element_instance)
	active_elements.append(element_instance)
	
	# Connect tree exit signal to clean up reference tracking automatically
	element_instance.tree_exited.connect(func(): active_elements.erase(element_instance))
