extends Node2D

@export var physical_button: Area2D

func _on_x_button_closed() -> void:
	queue_free()

func _process(_delta: float) -> void:
	if not is_instance_valid(physical_button):
		return

	if physical_button.get("pressed") or physical_button.get("button_pressed"):
		visible = true
	else:
		visible = false
