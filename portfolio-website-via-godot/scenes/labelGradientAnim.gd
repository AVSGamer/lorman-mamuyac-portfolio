extends Control # Works on both standard Label and RichTextLabel nodes

# --- Configuration Settings ---
@export var transition_speed: float = 2.5 # Lower numbers mean slower, smoother blends

# Your portfolio palette swatch array
var theme_colors: Array[Color] = [
	Color(0.1, 0.9, 0.3),     # Matrix Green
	Color(0.02, 0.23, 0.33),  # Your Hex #053B53 Dark Blue
	Color(0.96, 0.84, 0.48),  # Warm Window Yellow
	Color(1.0, 0.2, 0.2)      # Red Skyscraper Beacon Core
]

var current_color_index: int = 0
var next_color_index: int = 1
var blend_progress: float = 0.0

func _process(delta: float) -> void:
	# 1. Advance the blending factor based on clock frames
	blend_progress += delta * (transition_speed / 2.0)
	
	# 2. When the blend finishes, shift indices up the array ladder
	if blend_progress >= 1.0:
		blend_progress = 0.0
		current_color_index = next_color_index
		next_color_index = (next_color_index + 1) % theme_colors.size()
		
	# 3. Calculate the smooth intermediate color step
	var current_color: Color = theme_colors[current_color_index]
	var target_color: Color = theme_colors[next_color_index]
	
	# 4. Tint the text node uniformly 
	modulate = current_color.lerp(target_color, blend_progress)
