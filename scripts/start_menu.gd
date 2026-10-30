extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _on_restart_pressed() -> void:
	$"../../../../Player".die()
	

func _on_achievements_pressed() -> void:
	%Achievements_window.show_window()
	visible = false


func _on_info_pressed() -> void:
	pass # Replace with function body.


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_start_pressed() -> void:
	visible = !visible


func _on_button_x_button_down() -> void:
	pass # Replace with function body.
