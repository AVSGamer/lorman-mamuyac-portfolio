extends Node

@onready var error_player: AudioStreamPlayer = $ErrorSound
@onready var success_player: AudioStreamPlayer = $SuccessSound

func _ready() -> void:
	# 1. Initialize empty generator stream objects
	var err_stream = AudioStreamGenerator.new()
	var succ_stream = AudioStreamGenerator.new()
	
	err_stream.mix_rate = 22050
	succ_stream.mix_rate = 22050
	
	error_player.stream = err_stream
	success_player.stream = succ_stream
	
	# 2. Pre-generate and bake our sound data patterns into playback buffers
	_generate_beep(error_player, 180.0, 0.15)     # Low pitch short buzz for errors
	_generate_beep(success_player, 880.0, 0.12)   # High pitch pleasant chime for correct text

func _generate_beep(player: AudioStreamPlayer, frequency: float, duration: float) -> void:
	player.play() # Temporarily start playback framework to hook playback engine references
	var playback = player.get_stream_playback()
	if not playback: return
	
	var sample_rate = player.stream.mix_rate
	var total_frames = int(sample_rate * duration)
	
	# Generate a basic square wave form sequence for an arcade feel
	for i in range(total_frames):
		var phase = fmod(i * frequency / sample_rate, 1.0)
		var sample_value = 0.1 if phase < 0.5 else -0.1
		
		# Linear volume decay fade out over duration length to stop clicking pops
		var volume_fade = 1.0 - (float(i) / total_frames)
		playback.push_frame(Vector2.ONE * sample_value * volume_fade)
		
	player.stop() # Return player node back to standby pool
