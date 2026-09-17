extends CharacterBody2D

const SPEED = 250.0
@onready var sprite = $Sprite2D

const max_tilt = deg_to_rad(10)
const tilt_speed = 8.0

@export var texture_idle: Texture2D
@export var texture_left: Texture2D
@export var texture_right: Texture2D

signal moved_mouse(dir)

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
	var moved_by = get_real_velocity() * delta
	moved_mouse.emit(moved_by)
	
	update_texture()
	
func update_texture() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		sprite.texture = texture_left
	#elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
	#	sprite.texture = texture_right
	else:
		sprite.texture = texture_idle
