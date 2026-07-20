extends Node2D
class_name FallingElement

# Public variables assigned by the spawner
var word_text: String = ""
var target_number: String = ""
var base_speed: float = 60.0
var speed_modifier: float = 1.0
var fallDirection: int = 0
var xstartpos: float = 0.0
var ystartpos: float = 0.0

@onready var word_label: Label = $VisualContainer/WordLabel

func _ready() -> void:
	word_label.text = word_text
	xstartpos = position.x
	ystartpos = position.y

func init(new_font_size: int, new_font: Font, fD: int) -> void:
	if not is_node_ready():
		await ready 
	word_label.label_settings.font = new_font
	word_label.label_settings.font_size = new_font_size
	fallDirection = fD

func _process(delta: float) -> void:
	var current_velocity = base_speed * speed_modifier
	if fallDirection == 0:
		position.y += current_velocity * delta
		if position.y > get_viewport_rect().size.y - 80:
			_on_missed_element()
	elif fallDirection == 1:
		position.x += current_velocity * delta
		if position.x > get_viewport_rect().size.x - 80:
			_on_missed_element()
	elif fallDirection == 2:
		position.x -= current_velocity * delta
		if position.x < 80:
			_on_missed_element()
	elif fallDirection == 3:
		if ystartpos == 0:
			position.y += current_velocity * delta
			if position.y > get_viewport_rect().size.y - 80:
				_on_missed_element()
		elif xstartpos == 0:
			position.x += current_velocity * delta
			if position.x > get_viewport_rect().size.x - 80:
				_on_missed_element()
		elif xstartpos > 0 and ystartpos > 0:
			position.x -= current_velocity * delta
			if position.x < 80:
				_on_missed_element()

func _on_missed_element() -> void:
	# Element slipped through without being solved; cleanup instance
	queue_free()
