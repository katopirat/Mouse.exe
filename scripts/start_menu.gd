extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../Taskbar/HBoxContainer/Start/RedDot".visible = false
	for c in $VBoxContainer.get_children():
		c.get_child(0).remove_from_group("clickable")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.red_dot:
		show_red_dot()
	


func _on_restart_pressed() -> void:
	$"../../../../Player".die()
	

func _on_achievements_pressed() -> void:
	%Achievements_window.show_window()
	visible = false


func _on_info_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/crredits_test.tscn")


func _on_settings_pressed() -> void:
	%Settings_window.show_window()
	visible = false

func _on_start_pressed() -> void:
	visible = !visible
	
	for c in $VBoxContainer.get_children():
		if visible == true:
			c.get_child(0).add_to_group("clickable")
		elif visible == false: 
			c.get_child(0).remove_from_group("clickable")


func _on_button_x_button_down() -> void:
	pass # Replace with function body.
	
func show_red_dot():
	while !visible:
		$"../Taskbar/HBoxContainer/Start/RedDot".visible = true
		await get_tree().process_frame
	$"../Taskbar/HBoxContainer/Start/RedDot".visible = false

	
