extends Area2D
signal upgrade()

func _input(event):
	
	if event.is_action_pressed("click") and Global.player_can_move and self == Global.highest_clickable_body:
		upgrade.emit()
