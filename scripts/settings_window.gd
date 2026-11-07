extends Control
@onready var s_container = $PanelContainer/VBoxContainer/ScrollContainer/VBoxContainer





func show_window():
	Global.player_can_move = false
	GameState.game_pausable = false
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	
func _ready() -> void:
	$PanelContainer/VBoxContainer/VBoxContainer/Volume/Label2.text = "70"
	Music.set_master_volume(70)
	visible = false
	


func _on_texture_button_button_down() -> void:
	GameState.game_pausable = true
	visible = false
	Global.player_can_move = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_h_slider_value_changed(value: float) -> void:
	$PanelContainer/VBoxContainer/VBoxContainer/Volume/Label2.text = str(int(value))
	Music.set_master_volume(value)


func _on_button_pressed() -> void:
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/Label.visible = true
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/VBoxContainer/Yes.visible = true
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/VBoxContainer/Yes.disabled = false
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/VBoxContainer/No.visible = true
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/VBoxContainer/No.disabled = false


func _on_yes_pressed() -> void:
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/Label.visible = false
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/VBoxContainer/Yes.visible = false
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/VBoxContainer/Yes.disabled = true
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/VBoxContainer/No.visible = false
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/VBoxContainer/No.disabled = true
	GameState.game_pausable = true
	await GameState.reset_game()
	$"../../Player".die()



func _on_no_pressed() -> void:
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/Label.visible = false
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/VBoxContainer/Yes.visible = false
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/VBoxContainer/Yes.disabled = true
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/VBoxContainer/No.visible = false
	$PanelContainer/VBoxContainer/VBoxContainer/Reset/VBoxContainer/No.disabled = true
