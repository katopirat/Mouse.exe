extends Control
@onready var s_container = $PanelContainer/VBoxContainer/ScrollContainer/VBoxContainer





func show_window():
	Global.player_can_move = false
	GameState.game_pausable = false
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	

	


func _on_texture_button_button_down() -> void:
	GameState.game_pausable = true
	visible = false
	Global.player_can_move = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
