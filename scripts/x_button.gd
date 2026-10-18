extends Area2D
var cursor_inside = false
signal closed()
func _ready() -> void:
	add_to_group("clickable")
func _process(delta: float) -> void:
	if self == Global.highest_clickable_body:
		$AnimatedSprite2D.play("hovered")
	else:
		$AnimatedSprite2D.play("default")
	

func _input(event):
	
	if event.is_action_pressed("click") and Global.player_can_move and self == Global.highest_clickable_body:
		print("clicked x")
		closed.emit()
		
