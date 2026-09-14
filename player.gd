extends CharacterBody2D

const SPEED = 250.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	move_and_slide()
