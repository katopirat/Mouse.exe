extends CharacterBody2D

const SPEED = 250.0
@onready var sprite = $Sprite2D

var max_tilt = deg_to_rad(120)
var tilt_speed = 8.0

func _physics_process(delta: float) -> void:
	var target_tilt = 0.0
	
	if velocity.x < 0:
		target_tilt = -max_tilt
	elif velocity.x > 0:
		target_tilt = max_tilt
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED
	sprite.rotation = lerp_angle(sprite.rotation,target_tilt,delta * tilt_speed)
	move_and_slide()
	
