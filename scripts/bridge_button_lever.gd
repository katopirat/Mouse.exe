extends Area2D
var cursor_inside = false
var is_pressed = false

signal open_bridge()
signal close_bridge()

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Cursor":
		cursor_inside = true
 
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Cursor":
		cursor_inside = false

func _input(event):
	
	if cursor_inside and event.is_action_pressed("click"):
		print("a")
		if is_pressed:
			close_bridge.emit()
			$AnimatedSprite2D.play("default")
			is_pressed = false
		else:
			open_bridge.emit()
			$AnimatedSprite2D.play("pressed")
			is_pressed = true
		
