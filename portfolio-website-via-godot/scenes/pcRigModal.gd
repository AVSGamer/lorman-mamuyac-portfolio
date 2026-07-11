extends Control

# --- Unique Node Name Fallbacks ---
# Godot 4.x uses '%' to find unique nodes anywhere in the current scene tree
@onready var title_label: Label = $%PartTitleLabel
@onready var desc_label: RichTextLabel = $%PartDescription
@onready var part_image: TextureRect = $%PartTextureRect
@onready var outside_click_detector: Control = $%OutsideClickDetector
@onready var modal_window_body: Control = $%ModalBody

func _ready() -> void:
	# 1. ENFORCE SAFETY MOUSE LAYOUT MAPS
	if outside_click_detector:
		outside_click_detector.mouse_filter = Control.MOUSE_FILTER_STOP
		outside_click_detector.gui_input.connect(_on_outside_clicked)
		
	if modal_window_body:
		# Ensure clicking inside the card body stops the event from reaching the detector
		modal_window_body.mouse_filter = Control.MOUSE_FILTER_STOP

func populate_modal_data(data: Dictionary) -> void:
	# Double-check references aren't null before assigning text assets
	if title_label: 
		title_label.text = data.get("title", "Hardware Spec")
	else:
		push_error("Modal Title Label node could not be resolved at runtime!")
		
	if desc_label: 
		desc_label.bbcode_enabled = true
		desc_label.text = data.get("desc", "")
	
	if part_image and ResourceLoader.exists(data.get("image_path", "")):
		part_image.texture = load(data["image_path"])

func _on_outside_clicked(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Purge modal block safely from layout view tracking threads
			queue_free()
