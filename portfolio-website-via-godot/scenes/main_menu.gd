extends Control

@onready var ad_container: MarginContainer = $%AdContainer

# Preload core scenes
const BIOGRAPHY_SCENE = preload("res:///scenes/mini_biography.tscn")
const COMP_RIG_SCENE = preload("res:///scenes/comp_rig.tscn")
const PROJECTS_SCENE = preload("res://scenes/projects.tscn")
const FUTURE_FEATURE_SCENE = preload("res://scenes/gameEntryModal.tscn")
const MINI_GAME_1_SCENE = preload("res://scenes/game_WordNumberMaster.tscn")

func _ready() -> void:
	pass

# ─── BUTTONS ROUTING ───
func _on_future_feature_mm_pressed() -> void:
	var scene_instance = FUTURE_FEATURE_SCENE.instantiate()
	$%StaticUIOverlayMain.add_child(scene_instance)
	scene_instance.miniGame1Start.connect(_on_mini_game1_start)

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
	
func _on_mini_game1_start() -> void:
	$%MainMenuScreen.hide()
	var scene_instance = MINI_GAME_1_SCENE.instantiate()
	$%StaticUIOverlayMain.add_child(scene_instance)
	
func _clear_current_container() -> void:
	for child in $%StaticUIOverlayMain.get_children():
		if not child == $%MainMenuScreen:
			child.queue_free()

func _on_mini_biography_mm_mouse_entered() -> void:
	$StaticUIOverlayMain/MainMenuScreen/VBoxContainer/VBoxContainer/MiniBiographyMM.text = ">> Curriculum Vitae / Related Biography <<"


func _on_mini_biography_mm_mouse_exited() -> void:
	$StaticUIOverlayMain/MainMenuScreen/VBoxContainer/VBoxContainer/MiniBiographyMM.text = "Curriculum Vitae / Related Biography"


func _on_computer_rig_mm_mouse_entered() -> void:
	$StaticUIOverlayMain/MainMenuScreen/VBoxContainer/VBoxContainer/ComputerRigMM.text = ">> My Current Devices <<"


func _on_computer_rig_mm_mouse_exited() -> void:
	$StaticUIOverlayMain/MainMenuScreen/VBoxContainer/VBoxContainer/ComputerRigMM.text = "My Current Devices"


func _on_projects_mm_mouse_entered() -> void:
	$StaticUIOverlayMain/MainMenuScreen/VBoxContainer/VBoxContainer/ProjectsMM.text = ">> Projects <<"


func _on_projects_mm_mouse_exited() -> void:
	$StaticUIOverlayMain/MainMenuScreen/VBoxContainer/VBoxContainer/ProjectsMM.text = "Projects"


func _on_mm_lbl_game_profile_mouse_entered() -> void:
	$StaticUIOverlayMain/MainMenuScreen/VBoxContainer/mm_lblGameProfile.text = "-- VSGamer i PapiRE - Gaming --"


func _on_mm_lbl_game_profile_mouse_exited() -> void:
	$StaticUIOverlayMain/MainMenuScreen/VBoxContainer/mm_lblGameProfile.text = "VSGamer i PapiRE - Gaming"


func _on_mm_lbl_github_profile_mouse_entered() -> void:
	$StaticUIOverlayMain/MainMenuScreen/VBoxContainer/mm_lblGithubProfile.text = ">> Khayeel(Programming) <<
>> PapiRES(Program Publishing) <<"


func _on_mm_lbl_github_profile_mouse_exited() -> void:
	$StaticUIOverlayMain/MainMenuScreen/VBoxContainer/mm_lblGithubProfile.text = "Khayeel(Programming)
PapiRES(Program Publishing)"


func _on_mm_lbl_linkdin_profile_mouse_entered() -> void:
	$StaticUIOverlayMain/MainMenuScreen/VBoxContainer/mm_lblLinkdinProfile.text = ">> made by: Lorman Domingo Mamuyac <<
[:Pen Names:]"


func _on_mm_lbl_linkdin_profile_mouse_exited() -> void:
	$StaticUIOverlayMain/MainMenuScreen/VBoxContainer/mm_lblLinkdinProfile.text = "made by: Lorman Domingo Mamuyac
[:Pen Names:]"
