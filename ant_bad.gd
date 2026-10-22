extends CharacterBody2D

@onready var target : CharacterBody2D = $"../Player"



const SPEED = 200.0

func _physics_process(delta: float) -> void:
	if global_position.distance_to(target.global_position)>40: 
		
		var direction=(target.position-position).normalized()
		velocity=direction * SPEED
		look_at(target.position)

		move_and_slide()
