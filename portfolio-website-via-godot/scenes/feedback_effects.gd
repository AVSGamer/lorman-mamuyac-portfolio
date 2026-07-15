extends AnimationPlayer

@onready var input_box: LineEdit = get_node("../GameUI/Control/MarginContainer/VBoxContainer/InputBar/TypingInput")

var is_shaking: bool = false
var shake_timer: float = 0.0
var shake_duration: float = 0.3
var shake_intensity: float = 12.0
var original_position: Vector2

func _ready() -> void:
	if input_box:
		original_position = input_box.position

func _process(delta: float) -> void:
	if is_shaking:
		shake_timer -= delta
		if shake_timer <= 0.0:
			is_shaking = false
			input_box.position = original_position
			input_box.add_theme_color_override("font_color", Color.WHITE)
		else:
			# Apply random offset calculations to mimic visual screen trauma shake
			var random_offset = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)) * shake_intensity
			input_box.position = original_position + random_offset

func trigger_error_feedback() -> void:
	if not input_box: return
	original_position = input_box.position
	shake_timer = shake_duration
	is_shaking = true
	# Flash red theme text style override
	input_box.add_theme_color_override("font_color", Color(1.0, 0.2, 0.2))
