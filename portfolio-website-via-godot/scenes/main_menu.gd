extends Control

@onready var ad_container: MarginContainer = $%AdContainer

# Preload core scenes
const BIOGRAPHY_SCENE = preload("res:///scenes/mini_biography.tscn")
const COMP_RIG_SCENE = preload("res:///scenes/comp_rig.tscn")
const PROJECTS_SCENE = preload("res://scenes/projects.tscn")
const FUTURE_FEATURE_SCENE = preload("res://scenes/futurefeature.tscn")

func _ready() -> void:
	pass

# ─── BUTTONS ROUTING ───
func _on_future_feature_mm_pressed() -> void:
	$%MainMenuScreen.hide()

func _on_mini_biography_mm_pressed() -> void:
	$%MainMenuScreen.hide()
	var scene_instance = BIOGRAPHY_SCENE.instantiate()
	$%StaticUIOverlayMain.add_child(scene_instance)
	scene_instance.return_to_menu.connect(_on_return_to_menu)

func _on_computer_rig_mm_pressed() -> void:
	$%MainMenuScreen.hide()
	var scene_instance = COMP_RIG_SCENE.instantiate()
	$%StaticUIOverlayMain.add_child(scene_instance)
	scene_instance.return_to_menu.connect(_on_return_to_menu)

func _on_projects_mm_pressed() -> void:
	$%MainMenuScreen.hide()
	var scene_instance = PROJECTS_SCENE.instantiate()
	$%StaticUIOverlayMain.add_child(scene_instance)
	scene_instance.return_to_menu.connect(_on_return_to_menu)

func _on_to_be_replaced_mm_pressed() -> void:
		get_tree().quit()

func _on_return_to_menu() -> void:
	_clear_current_container()
	$%MainMenuScreen.show()
	
func _clear_current_container() -> void:
	for child in $%StaticUIOverlayMain.get_children():
		if not child == $%MainMenuScreen:
			child.queue_free()
