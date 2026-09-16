extends Area2D
signal pressed
var cursor_inside = false
var is_pressed = false 

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Cursor":
		cursor_inside = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Cursor":
		cursor_inside = false

func _input(event):
	if cursor_inside and event.is_action_pressed("click"):
		if is_pressed:
			$Sprite2D.modulate = Color(1,0,0)
			is_pressed = false
		else:
			emit_signal("pressed")
			$Sprite2D.modulate = Color(1,1,1)
			is_pressed = true
		
