extends CharacterBody2D

@export var speed: float = 350.0
const max_tilt = deg_to_rad(10)
const tilt_speed = 8.0
const z_index_under_desk = -25
const fall_drop_distance = 60.0
const fall_drop_duration = 0.5
@export var table_tilemap: TileMap

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
	if Input.is_action_just_pressed("godmode") and god_mode:
		god_mode = false 
	elif Input.is_action_just_pressed("godmode") and not god_mode:
		god_mode = true
		Global.player_can_move = false
		$Node2D.visible = true
		$Node2D/AnimationPlayer.play("god_mode")
		
		await $Node2D/AnimationPlayer.animation_finishedg
		$Node2D/AnimationPlayer.play("RESET") 
		Global.player_can_move = true
	if Input.is_action_just_pressed("reset"):
		Global.player_can_move = false
		if shader_animation:
			shader_animation.play("close_screen")
			await shader_animation.animation_finished
		get_tree().reload_current_scene()
		
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
			
			# Pohyb v cíli
			move_and_slide()
			
			# Částice při nárazu v cílové animaci
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
	if not god_mode:
		_check_edge()

func update_texture() -> void:
	if Input.is_action_pressed("click"):
		$AnimatedSprite2D.play("left_click")
	else:
		$AnimatedSprite2D.play("idle")

func _check_edge() -> void:
	var edge_check_point = global_position
	if not _is_on_desk(edge_check_point):
		_fall()

func _on_finish_get_mouse_to_finish(pos: Vector2) -> void:
	finish_scene_animation = true
	finish_pos = pos

func _is_on_desk(point: Vector2) -> bool:
	var sample_points = [
						Vector2(0, col_shape.height/2), 
						Vector2(0,-col_shape.height/2), 
						Vector2(col_shape.radius/2, 0), 
						Vector2(-col_shape.radius/2, 0), 
						Vector2(0, 0)
						]
	for offest in sample_points:
		var cell = table_tilemap.local_to_map(table_tilemap.to_local(point+offest))
		var tile_data = table_tilemap.get_cell_tile_data(0, cell)
		if tile_data != null and tile_data.get_custom_data("on_table"):
			return true
	return false

func _fall() -> void:
	faling_sound.play()
	falling_now.emit(true)
	Global.player_can_move = false
	


	z_index = z_index_under_desk

	$AnimatedSprite2D.play("fall")

	var fall_tween = create_tween()
	fall_tween.tween_property($AnimatedSprite2D, "position:y", $AnimatedSprite2D.position.y + fall_drop_distance, fall_drop_duration)

	await $AnimatedSprite2D.animation_finished
	if shader_animation:
		shader_animation.play("close_screen")
		await shader_animation.animation_finished
	die()

func _on_table_table_changed(tilemap: TileMap) -> void:
	table_tilemap = tilemap

func die():
	get_tree().reload_current_scene()
