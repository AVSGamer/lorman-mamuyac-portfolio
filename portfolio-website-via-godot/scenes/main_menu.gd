extends Control

@onready var ad_container: MarginContainer = $%AdContainer
@onready var cv_biography: Button = $StaticUIOverlayMain/MainMenuScreen/AspectRatioContainer/VBoxContainer/VBoxContainer/MiniBiographyMM
@onready var comp_rig: Button = $StaticUIOverlayMain/MainMenuScreen/AspectRatioContainer/VBoxContainer/VBoxContainer/ComputerRigMM
@onready var projects: Button = $StaticUIOverlayMain/MainMenuScreen/AspectRatioContainer/VBoxContainer/VBoxContainer/ProjectsMM
@onready var gaming_profile_label: Label = $StaticUIOverlayMain/MainMenuScreen/AspectRatioContainer/VBoxContainer/mm_lblGameProfile
@onready var github_profile: Label = $StaticUIOverlayMain/MainMenuScreen/AspectRatioContainer/VBoxContainer/mm_lblGithubProfile
@onready var linkdin_profile: Label = $StaticUIOverlayMain/MainMenuScreen/AspectRatioContainer/VBoxContainer/mm_lblLinkdinProfile
@onready var root_scene: CanvasLayer = $%StaticUIOverlayMain

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
	root_scene.add_child(scene_instance)
	scene_instance.miniGame1Start.connect(_on_mini_game1_start)

func _on_mini_biography_mm_pressed() -> void:
	$%MainMenuScreen.hide()
	var scene_instance = BIOGRAPHY_SCENE.instantiate()
	root_scene.add_child(scene_instance)
	scene_instance.return_to_menu.connect(_on_return_to_menu)

func _on_computer_rig_mm_pressed() -> void:
	$%MainMenuScreen.hide()
	var scene_instance = COMP_RIG_SCENE.instantiate()
	root_scene.add_child(scene_instance)
	scene_instance.return_to_menu.connect(_on_return_to_menu)

func _on_projects_mm_pressed() -> void:
	$%MainMenuScreen.hide()
	var scene_instance = PROJECTS_SCENE.instantiate()
	root_scene.add_child(scene_instance)
	scene_instance.return_to_menu.connect(_on_return_to_menu)

func _on_to_be_replaced_mm_pressed() -> void:
		get_tree().quit()

func _on_return_to_menu() -> void:
	_clear_current_container()
	$%MainMenuScreen.show()
	
func _on_mini_game1_start() -> void:
	$%MainMenuScreen.hide()
	var scene_instance = MINI_GAME_1_SCENE.instantiate()
	root_scene.add_child(scene_instance)
	scene_instance.return_to_menu.connect(_on_return_to_menu)
	
func _clear_current_container() -> void:
	for child in root_scene.get_children():
		if not child == $%MainMenuScreen && not child == $%AdContainer:
			child.queue_free()

func _on_mini_biography_mm_mouse_entered() -> void:
	cv_biography.text = ">> Curriculum Vitae / Related Biography <<"


func _on_mini_biography_mm_mouse_exited() -> void:
	cv_biography.text = "Curriculum Vitae / Related Biography"


func _on_computer_rig_mm_mouse_entered() -> void:
	comp_rig.text = ">> My Current Devices <<"


func _on_computer_rig_mm_mouse_exited() -> void:
	comp_rig.text = "My Current Devices"


func _on_projects_mm_mouse_entered() -> void:
	projects.text = ">> Projects <<"


func _on_projects_mm_mouse_exited() -> void:
	projects.text = "Projects"


func _on_mm_lbl_game_profile_mouse_entered() -> void:
	gaming_profile_label.text = "-- VSGamer i PapiRE - Gaming --"


func _on_mm_lbl_game_profile_mouse_exited() -> void:
	gaming_profile_label.text = "VSGamer i PapiRE - Gaming"


func _on_mm_lbl_github_profile_mouse_entered() -> void:
	github_profile.text = ">> Khayeel(Programming) <<
>> PapiRES(Program Publishing) <<"


func _on_mm_lbl_github_profile_mouse_exited() -> void:
	github_profile.text = "Khayeel(Programming)
PapiRES(Program Publishing)"


func _on_mm_lbl_linkdin_profile_mouse_entered() -> void:
	linkdin_profile.text = ">> made by: Lorman Domingo Mamuyac <<
[:Pen Names:]"


func _on_mm_lbl_linkdin_profile_mouse_exited() -> void:
	linkdin_profile.text = "made by: Lorman Domingo Mamuyac
[:Pen Names:]"
