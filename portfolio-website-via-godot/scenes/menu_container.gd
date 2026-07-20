extends PanelContainer
signal font_selected(index: int)

@onready var main_label: Label = $SelectedTextLabel
@onready var scroll_box: ScrollContainer = $DropdownScroll
@onready var row_list: VBoxContainer = $DropdownScroll/VBoxContainer

var font_choices: Array = [
	{
		"name": "Data Control",
		"font_path": "res://assets/fonts/data-control/data-latin.ttf"
	},
	{
		"name": "Pixelic War",
		"font_path": "res://assets/fonts/pixelic-war/Pixelic War.ttf"
	},
	{
		"name": "Karmatic Arcade",
		"font_path": "res://assets/fonts/karmatic-arcade/ka1.ttf"
	},
	{
		"name": "Blox",
		"font_path": "res://assets/fonts/blox/Blox2.ttf"
	},
	{
		"name": "Arcade",
		"font_path": "res://assets/fonts/arcade/Arcade.ttf"
	},
	{
		"name": "Where My Keys",
		"font_path": "res://assets/fonts/where-my-keys/Where My Keys.otf"
	},
	{
		"name": "Park Tech",
		"font_path": "res://assets/fonts/park-tech-cg/Park Tech CG Light.ttf"
	},
	{
		"name": "Checkbook",
		"font_path": "res://assets/fonts/checkbook/CHECKBK0.TTF"
	},
	{
		"name": "Chintzy",
		"font_path": "res://assets/fonts/chintzy-cpu/chintzy.ttf"
	}
]

func _ready() -> void:
	scroll_box.hide() 
	$ToggleButton.pressed.connect(_on_menu_clicked)
	_generate_dropdown_rows()
	
	# Load the previously saved global setting at launch so the menu matches
	
	_on_item_chosen(0, "Data Control", preload("res://assets/fonts/data-control/data-latin.ttf"))

func _generate_dropdown_rows() -> void:
	for child in row_list.get_children():
		child.queue_free()
		
	for i in range(font_choices.size()):
		var choice = font_choices[i]
		var item_button = Button.new()
		item_button.text = choice["name"]
		item_button.alignment = HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT
		
		var assigned_font = load(choice["font_path"])
		item_button.add_theme_font_override("font", assigned_font)
		
		item_button.pressed.connect(_on_item_chosen.bind(i, choice["name"], assigned_font))
		row_list.add_child(item_button)

func _on_menu_clicked() -> void:
	scroll_box.visible = !scroll_box.visible

func _on_item_chosen(index: int, selected_name: String, selected_font: Font) -> void:
	main_label.text = selected_name
	main_label.add_theme_font_override("font", selected_font)
	scroll_box.hide()
	font_selected.emit(index)
