extends CharacterBody2D
@onready var target= $"../ant_bad2"

const SPEED = 300.0

func _physics_process(delta: float) -> void:
	var direction=(target.position-position).normalized()
	velocity=direction * SPEED
	look_at(target.position)

	move_and_slide()
