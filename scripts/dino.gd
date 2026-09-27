extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -390.0

func _ready() -> void:
	$AnimatedSprite2D.play("run")
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("click") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	move_and_slide()
