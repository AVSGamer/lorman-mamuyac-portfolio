extends AspectRatioContainer
signal miniGame1Start

@onready var outside_click_detector: Control = self
@onready var modal_window_body: Control = $%mc_MModalWindow
@onready var future_feature: Button = $mc_ModalGameEntry/mc_MModalWindow/VBoxContainer/btn_future_feature
@onready var mini_games: Button = $mc_ModalGameEntry/mc_MModalWindow/VBoxContainer/btn_MiniGames
@onready var tools: Button = $mc_ModalGameEntry/mc_MModalWindow/VBoxContainer/btn_Tools
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if outside_click_detector:
		outside_click_detector.mouse_filter = Control.MOUSE_FILTER_STOP
		outside_click_detector.gui_input.connect(_on_outside_clicked)
	
	if modal_window_body:
		modal_window_body.mouse_filter = Control.MOUSE_FILTER_STOP

	future_feature.mouse_entered.connect(_on_btn_future_feature_mouse_entered)
	mini_games.mouse_entered.connect(_on_btn_mini_games_mouse_entered)
	tools.mouse_entered.connect(_on_btn_tools_mouse_entered)
	future_feature.mouse_exited.connect(_on_btn_future_feature_mouse_exited)
	mini_games.mouse_exited.connect(_on_btn_mini_games_mouse_exited)
	tools.mouse_exited.connect(_on_btn_tools_mouse_exited)
	
func _process(_delta: float) -> void:
	pass
	
func _on_outside_clicked(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			self.queue_free()

func _on_btn_future_feature_mouse_entered() -> void:
	future_feature.text = ">> ????????? <<"
	future_feature.add_theme_font_size_override("font_size",30)
	
func _on_btn_future_feature_mouse_exited() -> void:
	future_feature.text = "?????????"
	future_feature.add_theme_font_size_override("font_size",28)

func _on_btn_mini_games_mouse_entered() -> void:
	mini_games.text = ">> Mini Games <<"
	mini_games.add_theme_font_size_override("font_size",30)
	
func _on_btn_mini_games_mouse_exited() -> void:
	mini_games.text = "Mini Games"
	mini_games.add_theme_font_size_override("font_size",28)
	
func _on_btn_tools_mouse_entered() -> void:
	tools.text = ">> Tools <<"
	tools.add_theme_font_size_override("font_size",30)
	
func _on_btn_tools_mouse_exited() -> void:
	tools.text = "Tools"
	tools.add_theme_font_size_override("font_size",28)


func _on_btn_mini_games_button_up() -> void:
	emit_signal("miniGame1Start")
	self.queue_free()
