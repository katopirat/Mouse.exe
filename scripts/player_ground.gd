extends CharacterBody2D

@export var speed: float = 350.0
const max_tilt = deg_to_rad(10)
const tilt_speed = 8.0
const z_index_under_desk = -25
const fall_drop_distance = 60.0
const fall_drop_duration = 0.5
@export var table_tilemap: TileMap
var is_dying: bool = false

var finish: Area2D = null

signal falling_now(fall: bool)
@onready var faling_sound: AudioStreamPlayer = $AudioStreamPlayerFalling
signal moved_mouse(dir)
var god_mode: bool = false
@onready var finish_scene_animation = false
@onready var finish_pos: Vector2
signal animation_finished
@onready var shader_animation:AnimationPlayer = $"../CanvasLayer/AnimationTree"
@onready var col_shape = $CollisionShape2DFall.shape
@onready var particles = $CPUParticles2D

func _ready() -> void:
	
	if has_node("../Finish"):
		finish = get_node("../Finish")
		finish.get_mouse_to_finish.connect(_on_finish_get_mouse_to_finish)
	else:
		print("skibidi warning : no finish")
		finish = null

	if shader_animation:
		shader_animation.play("screen_open")
		await shader_animation.animation_finished
		shader_animation.play("RESET")
	Global.player_can_move = true
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("godmode") and god_mode and Global.player_can_move:
		god_mode = false
		
	elif Input.is_action_just_pressed("godmode") and not god_mode:
		god_mode = true
		Global.player_can_move = false
		$Node2D.visible = true
		$Node2D/AnimationPlayer.play("god_mode")
		
	elif Input.is_action_just_pressed("godmode") and god_mode and $Node2D/AnimationPlayer.is_playing() and $Node2D/AnimationPlayer.current_animation == "god_mode":
		$Node2D/AnimationPlayer.play("RESET") 
		Global.player_can_move = true
		
	if god_mode and not Global.player_can_move and not $Node2D/AnimationPlayer.is_playing():
		$Node2D/AnimationPlayer.play("RESET") 
		Global.player_can_move = true
	if Input.is_action_just_pressed("reset") and not is_dying:
		is_dying = true
		set_physics_process(false)
		Global.player_can_move = false
		die()
		return

		
	if not Global.player_can_move:
		if finish_scene_animation:
			var target_tilt = 0.0
			if velocity.x < 0:
				target_tilt = -max_tilt
			elif velocity.x > 0:
				target_tilt = max_tilt
			
			var direction := global_position.direction_to(finish_pos)
			if global_position.distance_to(finish_pos) < 10:
				velocity = direction * 0
			else:
				velocity = direction * 200
			$AnimatedSprite2D.rotation = lerp_angle($AnimatedSprite2D.rotation, target_tilt, delta * tilt_speed)
			move_and_slide()
			
			if get_slide_collision_count() > 0:
				var colision = get_slide_collision(0)
				particles.global_rotation = colision.get_normal().angle()
				if not particles.emitting:
					particles.emitting = true
			
			if global_position.distance_to(finish_pos) < 10 and $AnimatedSprite2D.rotation < 5:
				if shader_animation:
					shader_animation.play("close_screen")
					await shader_animation.animation_finished
				emit_signal("animation_finished")
		return

	var target_tilt = 0.0
	if velocity.x < 0:
		target_tilt = -max_tilt
	elif velocity.x > 0:
		target_tilt = max_tilt
	
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	$AnimatedSprite2D.rotation = lerp_angle($AnimatedSprite2D.rotation, target_tilt, delta * tilt_speed)
	
	move_and_slide()

	if get_slide_collision_count() > 0:
		var colision = get_slide_collision(0)
		particles.global_rotation = colision.get_normal().angle() 
		if not particles.emitting:
			pass
		particles.emitting = true

	var moved_by = get_real_velocity() * delta
	moved_mouse.emit(moved_by)

	update_texture()


func update_texture() -> void:
	if Input.is_action_pressed("click"):
		$AnimatedSprite2D.play("left_click")
	else:
		$AnimatedSprite2D.play("idle")



func _on_finish_get_mouse_to_finish(pos: Vector2) -> void:
	finish_scene_animation = true
	finish_pos = pos







func die():
	print("dying")
	Global.player_can_move = false
	if not is_inside_tree():
		print('r')
		return
	if $AudioStreamPlayer:
		$AudioStreamPlayer.play()
	if shader_animation:
		shader_animation.play("close_screen")
		await shader_animation.animation_finished
	if is_inside_tree() and get_tree():
		get_tree().reload_current_scene()
