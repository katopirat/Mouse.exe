extends Control
@onready var s_container = $PanelContainer/VBoxContainer/ScrollContainer/VBoxContainer





func show_window():
	Global.player_can_move = false
	GameState.game_pausable = false
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	
func _ready() -> void:
	visible = false
	


func _on_texture_button_button_down() -> void:
	GameState.game_pausable = true
	visible = false
	Global.player_can_move = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_h_slider_value_changed(value: float) -> void:
	$PanelContainer/VBoxContainer/VBoxContainer/Volume/Label2.text = str(int(value))
	print($PanelContainer/VBoxContainer/VBoxContainer/Volume/Label2.text)
