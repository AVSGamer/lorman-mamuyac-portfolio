extends RichTextLabel

# Reference to your custom Tooltip UI node (e.g., a PanelContainer with a Label)
@onready var web_tooltip: PanelContainer = $%WebToolTip
@onready var tooltip_label: Label = $%ToolTipLabel

func _ready() -> void:
	# Ensure meta signaling is active on the RichTextLabel
	meta_underlined = true

func _sanitize_url(meta: Variant) -> Variant:
	if not meta.begins_with("https://"):
		meta = "https://" + meta
	return meta

func _on_meta_clicked(meta: Variant) -> void:
	var url_string: String = str(meta)
	var url_string_sand: String = _sanitize_url(url_string)	
	OS.shell_open(url_string_sand)

func _on_meta_hover_started(meta: Variant) -> void:
	var url_string: String = str(meta)
	var url_string_sand: String = _sanitize_url(url_string)	
	tooltip_label.text = url_string_sand
	web_tooltip.visible = true
	web_tooltip.show()

func _process(_delta: float) -> void:
	# Dynamically track the mouse cursor positioning for the web-style tooltip
	if web_tooltip.visible:
		var mouse_pos: Vector2 = get_global_mouse_position()
		# Offset slightly down and right from the cursor tip to prevent flickering
		web_tooltip.global_position = mouse_pos + Vector2(15, 15)

func _on_meta_hover_ended(_meta: Variant) -> void:
	web_tooltip.hide()
