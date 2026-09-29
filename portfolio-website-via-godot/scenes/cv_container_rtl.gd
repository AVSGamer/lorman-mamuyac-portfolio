extends RichTextLabel

# Reference to your custom Tooltip UI node (e.g., a PanelContainer with a Label)
@export var web_tooltip: PanelContainer
@export var tooltip_label: Label

func _ready() -> void:
	# Ensure meta signaling is active on the RichTextLabel
	meta_underlined = true
	
	# Connect Godot 4 standard hover and click signals programmatically
	meta_clicked.connect(_on_meta_clicked)
	meta_hover_started.connect(_on_meta_hover_started)
	meta_hover_ended.connect(_on_meta_hover_ended)

func _on_meta_clicked(meta: Variant) -> void:
	var url_string: String = str(meta)
	
	# Engine-level sanitation: automatically prepend protocol if missing
	if not url_string.begins_with("http://") and not url_string.begins_with("https://"):
		url_string = "https://" + url_string
		
	OS.shell_open(url_string)

func _on_meta_hover_started(meta: Variant) -> void:
	if web_tooltip and tooltip_label:
		var url_string: String = str(meta)
		
		# Sanitize tooltip text presentation cleanly
		if not url_string.begins_with("http://") and not url_string.begins_with("https://"):
			url_string = "https://" + url_string
			
		tooltip_label.text = url_string
		web_tooltip.show()

func _process(_delta: float) -> void:
	# Dynamically track the mouse cursor positioning for the web-style tooltip
	if web_tooltip and web_tooltip.visible:
		var mouse_pos: Vector2 = get_global_mouse_position()
		# Offset slightly down and right from the cursor tip to prevent flickering
		web_tooltip.global_position = mouse_pos + Vector2(15, 15)

func _on_meta_hover_ended(_meta: Variant) -> void:
	if web_tooltip:
		web_tooltip.hide()
