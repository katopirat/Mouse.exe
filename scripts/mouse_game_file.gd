extends Area2D
var cursor_inside = false
var is_pressed = 0
@onready var game_window = $"../Window"

func _ready() -> void:
	$"..".remove_child.call_deferred(game_window)
	$Sprite2D.play('default')
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
	if event.is_action_pressed("click"):
		if cursor_inside:
			if is_pressed == 0:
				is_pressed = 1
				$Sprite2D.play("clicked")
			elif is_pressed == 1:
				is_pressed = 2
				$"..".add_child(game_window)
				queue_free()
				
		else:
			is_pressed = 0
			$Sprite2D.play('default')
