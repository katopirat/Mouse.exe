extends Area2D

signal player_fell()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("you fell")
		player_fell.emit()
