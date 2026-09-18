extends CharacterBody2D

const SPEED = 250.0
@onready var sprite = $Sprite2D

const max_tilt = deg_to_rad(10)
const tilt_speed = 8.0

signal moved_mouse(dir)
var can_move = true
func _physics_process(delta: float) -> void:
	if can_move:
		var target_tilt = 0.0
		
		if velocity.x < 0:
			target_tilt = -max_tilt
		elif velocity.x > 0:
			target_tilt = max_tilt
		var direction := Input.get_vector("left", "right", "up", "down")
		velocity = direction * SPEED
		$AnimatedSprite2D.rotation = lerp_angle($AnimatedSprite2D.rotation,target_tilt,delta * tilt_speed)
		move_and_slide()
		var moved_by = get_real_velocity() * delta
		moved_mouse.emit(moved_by)
		
		update_texture()
	
func update_texture() -> void:
	if can_move:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			$AnimatedSprite2D.play("left_click")
		#elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		#	sprite.texture = texture_right
		else:
			$AnimatedSprite2D.play("idle")


func _on_floor_player_fell() -> void:
	$AnimatedSprite2D.rotation = 0
	$AnimatedSprite2D.play("fall")
	can_move = false
