extends AspectRatioContainer
signal miniGame1Start

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_texture_rect_gui_input(event: InputEvent) -> void:
	#Might have to modify to include keyboard only operation and touchscreen mobiles.
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("miniGame1Start")
		self.queue_free()

func _on_button_1_button_up() -> void:
	emit_signal("miniGame1Start")
	self.queue_free()
