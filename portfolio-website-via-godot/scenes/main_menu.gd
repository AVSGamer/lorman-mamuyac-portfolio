extends Control

@onready var main_menu_screen: MarginContainer = $StaticUIOverlay/MainMenuScreen
@onready var game_level_container: Node2D = $GameLevelContainer
@onready var ad_container: MarginContainer = $StaticUIOverlay/AdContainer

# Preload core scenes
const BIOGRAPHY_SCENE = preload("res:///scenes/mini_biography.tscn")
const COMP_RIG_SCENE = preload("res:///scenes/comp_rig.tscn")
const PROJECTS_SCENE = preload("res://scenes/projects.tscn")
const FUTURE_FEATURE_SCENE = preload("res://scenes/futurefeature.tscn")


func _ready() -> void:
	main_menu_screen.show()
	_clear_current_container()
	
	# If this is the paid desktop/android build, completely hide the web ad container
	#if OS.has_feature("windows") or OS.has_feature("linux") or OS.has_feature("android"):
	#	ad_container.queue_free()

# ─── BUTTONS ROUTING ───
func _on_future_feature_mm_pressed() -> void:
	main_menu_screen.hide()
	var game_instance = _transition_to_game()

func _on_mini_biography_mm_pressed() -> void:
	main_menu_screen.hide()
	_clear_current_container()
	var game_instance = BIOGRAPHY_SCENE.instantiate()
	game_level_container.add_child(game_instance)
	game_instance.return_to_menu.connect(_on_return_to_menu)

func _on_computer_rig_mm_pressed() -> void:
	main_menu_screen.hide()
	_clear_current_container()
	var game_instance = COMP_RIG_SCENE.instantiate()
	game_level_container.add_child(game_instance)
	game_instance.return_to_menu.connect(_on_return_to_menu)

func _on_projects_mm_pressed() -> void:
	main_menu_screen.hide()
	_clear_current_container()
	var game_instance = PROJECTS_SCENE.instantiate()
	game_level_container.add_child(game_instance)
	game_instance.return_to_menu.connect(_on_return_to_menu)

func _on_to_be_replaced_mm_pressed() -> void:
		get_tree().quit()

# ─── CORE PIPELINE METHODS ───
func _transition_to_game() -> Node:
	_clear_current_container()
	var game_instance = FUTURE_FEATURE_SCENE.instantiate()
	game_level_container.add_child(game_instance)
	return game_instance

func _on_return_to_menu() -> void:
	_clear_current_container()
	main_menu_screen.show()

func _clear_current_container() -> void:
	for child in game_level_container.get_children():
		child.queue_free()
