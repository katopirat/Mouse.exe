extends PanelContainer
@onready var red_dot: = $"../Taskbar/HBoxContainer/Start/RedDot"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	red_dot.visible = false
	for c in $VBoxContainer.get_children():
		c.get_child(0).remove_from_group("clickable")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.red_dot:
		Global.red_dot = false
		if !visible:
			red_dot.visible = true


func _on_restart_pressed() -> void:
	$"../../../../Player".die()
	

func _on_achievements_pressed() -> void:
	%Achievements_window.show_window()
	visible = false


func _on_info_pressed() -> void:
	$"../../../../CanvasLayer/AnimationTree".play("close_screen")
	Global.player_can_move = false
	await $"../../../../CanvasLayer/AnimationTree".animation_finished
	get_tree().change_scene_to_file("res://scenes/crredits_test.tscn")


func _on_settings_pressed() -> void:
	%Settings_window.show_window()
	visible = false

func _on_start_pressed() -> void:
	visible = !visible
	if visible:
		red_dot.visible = false
	for c in $VBoxContainer.get_children():
		if visible:
			c.get_child(0).add_to_group("clickable")
		else:
			c.get_child(0).remove_from_group("clickable")

func _on_button_x_button_down() -> void:
	pass # Replace with function body.
	

	
