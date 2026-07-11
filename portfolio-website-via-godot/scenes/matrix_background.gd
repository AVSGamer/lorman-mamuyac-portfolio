extends Node2D

# --- Node References ---
var falling_particles: GPUParticles2D
var window_particles: GPUParticles2D
var beacon_flare: Sprite2D

func _ready() -> void:
	# 1. SETUP MAIN CONTAINER & RESOLUTION HANDLING
	get_viewport().size_changed.connect(_on_screen_resized)
	
	# 2. INITIALIZE ALL VISUAL COMPONENTS
	_setup_tech_rain_particles()
	_setup_skyline_window_particles()
	_setup_skyscraper_beacon()
	
	# 3. TRIGGER INITIAL POSITIONING
	_on_screen_resized()

func _on_screen_resized() -> void:
	var screen_size: Vector2 = get_viewport_rect().size
	
	if falling_particles and falling_particles.process_material is ParticleProcessMaterial:
		falling_particles.position = Vector2(screen_size.x / 2, -10)
		falling_particles.process_material.emission_box_extents = Vector3(screen_size.x / 2, 1, 1)
		
	if window_particles and window_particles.process_material is ParticleProcessMaterial:
		window_particles.position = Vector2(screen_size.x / 2, screen_size.y * 0.875)
		window_particles.process_material.emission_box_extents = Vector3(screen_size.x / 2, screen_size.y * 0.125, 1)
	
func _setup_tech_rain_particles() -> void:
	falling_particles = GPUParticles2D.new()
	add_child(falling_particles)
	
	falling_particles.amount = 400
	falling_particles.lifetime = 4.0
	falling_particles.preprocess = 4.0
	falling_particles.texture = _generate_code_font_texture()
	
	var canvas_mat := CanvasItemMaterial.new()
	canvas_mat.particles_animation = true
	canvas_mat.particles_anim_h_frames = 2 
	canvas_mat.particles_anim_v_frames = 1
	canvas_mat.particles_anim_loop = false
	falling_particles.material = canvas_mat
	
	var mat := ParticleProcessMaterial.new()
	mat.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_BOX
	mat.direction = Vector3(0, 1, 0)
	mat.spread = 0.0
	mat.gravity = Vector3(0, 0, 0)
	mat.initial_velocity_min = 250.0 
	mat.initial_velocity_max = 450.0
	
	mat.particle_flag_align_y = true 
	
	var xyz_tex := CurveXYZTexture.new()
	var curve_x := Curve.new()
	curve_x.add_point(Vector2(0.0, 1.0))
	curve_x.add_point(Vector2(1.0, 1.0))
	
	var curve_y := Curve.new()
	curve_y.add_point(Vector2(0.0, 1.0))  
	curve_y.add_point(Vector2(1.0, 5.0))  
	
	xyz_tex.curve_x = curve_x
	xyz_tex.curve_y = curve_y
	
	mat.scale_over_velocity_curve = xyz_tex
	mat.scale_over_velocity_min = 0.0
	mat.scale_over_velocity_max = 450.0 
	
	mat.scale_min = 0.5
	mat.scale_max = 0.8
	
	mat.color = Color(0.1, 0.9, 0.3, 0.9) 
	
	var alpha_curve := CurveTexture.new()
	var curve := Curve.new()
	curve.add_point(Vector2(0.0, 1.0))
	curve.add_point(Vector2(0.7, 0.8))
	curve.add_point(Vector2(1.0, 0.0))
	alpha_curve.curve = curve
	mat.alpha_curve = alpha_curve
	
	mat.anim_speed_min = 0.0
	mat.anim_speed_max = 0.0
	mat.anim_offset_min = 0.0
	mat.anim_offset_max = 1.0
	
	falling_particles.process_material = mat
	falling_particles.visibility_rect = Rect2(-2000, -100, 4000, 3000)

func _setup_skyline_window_particles() -> void:
	window_particles = GPUParticles2D.new()
	add_child(window_particles)
	
	window_particles.amount = 250 
	window_particles.lifetime = 6.0
	window_particles.preprocess = 6.0
	window_particles.texture = _generate_single_pixel_texture()
	
	var mat := ParticleProcessMaterial.new()
	mat.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_BOX
	mat.gravity = Vector3(0, 0, 0)
	mat.initial_velocity_min = 0.0
	mat.initial_velocity_max = 0.0
	
	mat.scale_min = 2.7
	mat.scale_max = 2.7 
	mat.lifetime_randomness = 0.85
	
	var curve_tex := CurveTexture.new()
	var curve := Curve.new()
	curve.add_point(Vector2(0.0, 0.0))   
	curve.add_point(Vector2(0.1, 1.0))   
	curve.add_point(Vector2(0.85, 1.0))  
	curve.add_point(Vector2(1.0, 0.0))   
	curve_tex.curve = curve
	mat.alpha_curve = curve_tex
	
	mat.color = Color(0.02, 0.23, 0.33, 0.9) 
	mat.color_ramp = _generate_window_color_ramp()
	
	window_particles.process_material = mat
	window_particles.visibility_rect = Rect2(-2000, -1000, 4000, 2000)

func _setup_skyscraper_beacon() -> void:
	# ".."" steps UP to the parent, then we go DOWN into the image, then DOWN into the flare
	# REPLACE "YourBackgroundImageNodeName" with the exact name of your skyline image node!
	var beacon_path = "../TextureRect/BeaconFlare"
	
	if has_node(beacon_path):
		beacon_flare = get_node(beacon_path) as Sprite2D
	else:
		push_warning("Could not find BeaconFlare at sibling path: " + beacon_path)
		# Safe fallback creation if path is typed incorrectly
		beacon_flare = Sprite2D.new()
		add_child(beacon_flare)
	
	# 1. ASSIGN THE GLARE TEXTURE
	beacon_flare.texture = _generate_astigmatism_flare_texture()
	
	# 2. APPLY ADDITIVE GLOW BLENDING
	var canvas_mat := CanvasItemMaterial.new()
	canvas_mat.blend_mode = CanvasItemMaterial.BLEND_MODE_ADD
	beacon_flare.material = canvas_mat
	
	# Reset local visibility values
	beacon_flare.modulate = Color(1, 1, 1, 1)
	
	# 3. RUN THE PULSING ANIMATION
	var tween = create_tween().set_loops()
	tween.tween_property(beacon_flare, "modulate:a", 0.3, 1.5).set_trans(Tween.TRANS_SINE)
	tween.tween_property(beacon_flare, "modulate:a", 1.0, 1.5).set_trans(Tween.TRANS_SINE)


# --- Procedural Texture Mapping ---

func _generate_astigmatism_flare_texture() -> Texture2D:
	# Generates an anamorphic astigmatism cross-flare texture programmatically
	var width := 392
	var height := 392
	var img := Image.create(width, height, false, Image.FORMAT_RGBA8)
	var center := Vector2i(width / 2, height / 2)
	
	var core_color := Color(1.0, 0.9, 0.9, 1.0) # Bright white-red center core
	var red_glow := Color(1.0, 0.1, 0.1, 1.0)   # Vivid outer flare color
	
	# Pass 1: Draw the tight central glowing star core
	for y in range(height):
		for x in range(width):
			var dist = center.distance_to(Vector2i(x*6, y*6))
			if dist <= 12.0*6:
				var intensity = 1.0 - (dist / 12.0*6)
				img.set_pixel(x*6, y*6, red_glow.lerp(core_color, intensity * intensity))
				
	# Pass 2: Draw the long, sharp horizontal astigmatism ray streak
	for x in range(width):
		var dx = abs(x - center.x)
		var factor = 1.0 - (float(dx) / (width / 2.0)) # Dims as it reaches the edges
		if factor > 0:
			# Draw a sharp 3-pixel tall main horizontal streak line
			img.set_pixel(x, center.y, core_color.lerp(red_glow, 1.0 - factor))
			img.set_pixel(x, center.y - 1, red_glow * (factor * 0.5))
			img.set_pixel(x, center.y + 1, red_glow * (factor * 0.5))
			
	# Pass 3: Draw a secondary, subtle diagonal lens aberration glare ray angle (Optional)
	for i in range(-24, 24):
		var factor = 1.0 - (abs(i) / 24.0)
		img.set_pixel(center.x + i, center.y + (i * 2), red_glow * (factor * 0.4))
		
	return ImageTexture.create_from_image(img)

func _generate_code_font_texture() -> Texture2D:
	var size := 16
	var img := Image.create(size * 2, size, false, Image.FORMAT_RGBA8)
	var c := Color.WHITE
	
	# FRAME 0: Digital '0'
	for y in range(2, 14):
		for x in range(4, 12):
			if x == 4 or x == 11 or y == 2 or y == 13:
				img.set_pixel(x, y, c)
				
	# FRAME 1: Digital '1'
	for y in range(2, 14):
		img.set_pixel(size + 8, y, c)
		if y == 2:
			img.set_pixel(size + 7, y, c)
		if y == 13:
			for x in range(6, 11):
				img.set_pixel(size + x, y, c)
				
	return ImageTexture.create_from_image(img)

func _generate_single_pixel_texture() -> Texture2D:
	var img := Image.create(1, 1, false, Image.FORMAT_RGBA8)
	img.fill(Color.WHITE)
	return ImageTexture.create_from_image(img)

func _generate_window_color_ramp() -> GradientTexture1D:
	var gradient_tex := GradientTexture1D.new()
	var gradient := Gradient.new()
	gradient.set_color(0, Color(0.02, 0.23, 0.33, 1.0)) 
	gradient.set_color(1, Color(0.96, 0.84, 0.48, 1.0))  
	gradient_tex.gradient = gradient
	return gradient_tex
