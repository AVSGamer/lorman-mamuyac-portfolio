extends MarginContainer
signal return_to_menu
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_btn_back_to_menu_pressed() -> void:
	return_to_menu.emit()		

func _on_btn_back_to_menu_mouse_entered() -> void:
	$VBoxContainer/btn_backToMenu.text = ">> Return to Main Menu <<"

func _on_btn_back_to_menu_mouse_exited() -> void:
	$VBoxContainer/btn_backToMenu.text = ">>   Return to Main Menu   <<"
