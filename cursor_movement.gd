extends CharacterBody2D



const SPEED = 20.0


func _on_player_moved_mouse(dir: Variant) -> void:
	velocity = dir*SPEED
	move_and_slide()
