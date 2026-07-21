extends Label

# --- Configuration Settings ---
# Default fallback URL if the label's name isn't recognized in our list
@export var fallback_url: String = "https://www.bcs-ldm-code-lab.space/"

# Interactive UI Swatch Configurations
@export var normal_color := Color(1.0, 1.0, 1.0, 1.0)       # Crisp White
@export var hover_color := Color(0.1, 0.9, 0.3, 1.0)        # Matrix Tech Green
@export var click_flash_color := Color(0.96, 0.84, 0.48, 1.0) # Warm Window Yellow

# The active URL assigned to this specific instance
var active_url: String = ""

func _ready() -> void:
	# 1. CRITICAL: Allow mouse tracking and change cursor to a pointing hand
	mouse_filter = Control.MOUSE_FILTER_STOP
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	modulate = normal_color
	
	# 2. RUN LABEL NAME CHECKER TO ASSIGN UNIQUE LINKS
	_assign_url_by_self_name()
	
	# 3. Connect Engine Canvas Signals cleanly inside code
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	gui_input.connect(_on_gui_input)

func _assign_url_by_self_name() -> void:
	# Fetch the exact name of THIS label node from your Scene Dock tree hierarchy
	var node_name: String = self.name
	
	# Match checking conditions mapping label names to web links
	# CHANGE THESE STRINGS TO MATCH YOUR LABEL NAMES IN THE SCENE TREE!
	match node_name:
		"mm_lblGameProfile":
			active_url = "https://www.exophase.com/user/VSGamer/"
		"mm_lblGithubProfile":
			active_url = "https://github.com/AVSGamer"
		"mm_lblLinkdinProfile":
			active_url = "https://www.linkedin.com/in/lorman-mamuyac/"
		"lbl_proj_title3":
			active_url = "https://vsgamer57.itch.io/endlessly-overflowing-palette-by-papire"
		"lbl_proj_title4":
			active_url = "https://www.youtube.com/live/GH5HDL_AgRs?t=21301s"
		"lbl_proj_title5":
			active_url = "http://54.39.131.171:3000/home"
		"lbl_proj_title6":
			active_url = "https://genso.game/en/"
		"lbl_proj_title7":
			active_url = "https://docs.google.com/spreadsheets/d/1AoOrVXtKCoIY5Fv1FS4sY9G4hTHnqmfLGumQazG5KLI/"
		"lbl_proj_title8":
			active_url = "https://facebook.com/share/p/14b1ib4Ap6w/"
		"lbl_proj_title9":
			active_url = "https://www.facebook.com/marketplace/profile/100055752107854/?product_id=5493322714025670"
		"lbl_proj_title10":
			active_url = "https://www.esoui.com/downloads/info3072-XPTracker.html"
		"lbl_proj_title11":
			active_url = "https://facebook.com/photo/?fbid=222921229576279"
		_:
			# Default path handler if label name doesn't match any profiles above
			active_url = fallback_url

func _on_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate", hover_color, 0.15).set_trans(Tween.TRANS_SINE)

func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate", normal_color, 0.2).set_trans(Tween.TRANS_SINE)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			modulate = click_flash_color
		else:
			modulate = hover_color
			# Safely open the dynamically resolved URL
			OS.shell_open(active_url)
