extends CharacterBody2D



const SPEED = 50.0
func _on_moved_mouse(dir) -> void:
	velocity = dir*SPEED
	move_and_slide()
