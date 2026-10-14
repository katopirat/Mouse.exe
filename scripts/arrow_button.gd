extends StaticBody2D
@onready var cursor_inside = false

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
func _process(delta: float) -> void:
	if cursor_inside and Input.is_action_pressed("click") and Global.player_can_move:
		var event = InputEventAction.new()
		
