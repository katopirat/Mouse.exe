extends Area2D
var cursor_inside = false
var is_pressed = false
@onready var sound_player:AudioStreamPlayer = $AudioStreamPlayer
signal open_bridge()

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Cursor":
		cursor_inside = true
		if body.has_method("set_click_mode"):
			body.set_click_mode("hand")
 
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Cursor":
		cursor_inside = false
		if body.has_method("set_click_mode"):
			body.set_click_mode("arrow")

func _input(event):
	
	if cursor_inside and event.is_action_pressed("click"):
		print("a")
		if is_pressed:
			pass
		else:
			open_bridge.emit()
			sound_player.play()
			$AnimatedSprite2D.play("pressed")
			is_pressed = true
		
