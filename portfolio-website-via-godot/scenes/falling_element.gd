extends Node2D
class_name FallingElement

# Public variables assigned by the spawner
var word_text: String = ""
var target_number: String = ""
var base_speed: float = 60.0
var speed_modifier: float = 1.0

@onready var word_label: Label = $VisualContainer/WordLabel

func _ready() -> void:
	word_label.text = word_text

func _process(delta: float) -> void:
	# Compute total downward movement velocity scaled by dynamic difficulty
	var current_velocity = base_speed * speed_modifier
	position.y += current_velocity * delta
	
	# Fallback boundary check: Destroy if element drops past the viewport floor
	if position.y > get_viewport_rect().size.y - 80:
		_on_missed_element()

func _on_missed_element() -> void:
	# Element slipped through without being solved; cleanup instance
	queue_free()
