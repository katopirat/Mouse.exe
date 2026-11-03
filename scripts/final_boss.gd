extends Node2D

@onready var foot = $Foot
@onready var shadow_texture = $Foot/ShadowTexture
@onready var foot_texture = $Foot/FootTexture
@onready var top_left = $TopLeft
@onready var bottom_right = $BottomRight
@onready var player = $"../Player"
@onready var camera = $"../Player/Camera2D"
@onready var area = $Foot/Area2D
@onready var default_size: Vector2 = Vector2(2.2, 2.2)
@onready var foot_drop_time: float = 0.6
@onready var foot_on_ground_time: float = 7.0
@onready var folow_player_frames: int = 120


func _ready() -> void:
	remove_child(foot)
	main_loop()
func wait(time: float):
	await get_tree().create_timer(time).timeout
func main_loop():
	while true:
		add_child(foot)
		for s in range(randi_range(2, 4)):
			await funkce_ktera_dela_to_ze_noha_dupne_na_mys()
			await wait(1)
		remove_child(foot)
func random_pos():
	return Vector2(randf_range(top_left.global_position.x, bottom_right.global_position.x), randf_range(top_left.global_position.y, bottom_right.global_position.y))

	
func funkce_ktera_dela_to_ze_noha_dupne_na_mys():
	$Foot/CollisionShape2D.disabled = true
	shadow_texture.scale = default_size*1.2
	foot_texture.visible = false
	shadow_texture.visible = true
	shadow_texture.modulate = Color(0.0, 0.0, 0.0, 0.588)
	shadow_texture.material.set_shader_parameter("color",Color(0.0, 0.0, 0.0, 1.0))
	for i in folow_player_frames:
		foot.global_position = foot.global_position.lerp(player.global_position, 0.1)
		await get_tree().process_frame
	var t = create_tween().set_parallel(true)
	t.tween_property(shadow_texture,"material:shader_parameter/color",Color(0.6, 0.0, 0.0),foot_drop_time)
	t.tween_property(shadow_texture,"scale",default_size*0.9,foot_drop_time)
	await get_tree().create_timer(foot_drop_time).timeout
	
	foot_texture.scale = default_size
	foot_texture.visible = true
	
	var tw = create_tween().set_parallel(true)
	tw.tween_property(foot_texture,"scale",default_size,0.1)
	tw.tween_property(shadow_texture,"scale",default_size,0.1)
	await get_tree().create_timer(0.1).timeout
	shadow_texture.visible = false 
	camera.shake_intensity = 10
	await get_tree().physics_frame
	await get_tree().physics_frame
	for a in area.get_overlapping_bodies():
		if a.is_in_group("player"):
			a.die()
		print(a.name)
	$Foot/CollisionShape2D.disabled = false
					
	await get_tree().create_timer(foot_on_ground_time).timeout
	foot_texture.visible = false
	$Foot/CollisionShape2D.disabled = true
func fast_dup(feet):
	$Foot/CollisionShape2D.disabled = true
	shadow_texture.scale = default_size*1.2
	foot_texture.visible = false
	shadow_texture.visible = true
	shadow_texture.modulate = Color(0.0, 0.0, 0.0, 0.588)
	shadow_texture.material.set_shader_parameter("color",Color(0.0, 0.0, 0.0, 1.0))
	for i in folow_player_frames:
		foot.global_position = foot.global_position.lerp(player.global_position, 0.1)
		await get_tree().process_frame
	var t = create_tween().set_parallel(true)
	t.tween_property(shadow_texture,"material:shader_parameter/color",Color(0.6, 0.0, 0.0),foot_drop_time)
	t.tween_property(shadow_texture,"scale",default_size*0.9,foot_drop_time)
	await get_tree().create_timer(foot_drop_time).timeout
	
	foot_texture.scale = default_size
	foot_texture.visible = true
	
	var tw = create_tween().set_parallel(true)
	tw.tween_property(foot_texture,"scale",default_size,0.1)
	tw.tween_property(shadow_texture,"scale",default_size,0.1)
	await get_tree().create_timer(0.1).timeout
	shadow_texture.visible = false 
	camera.shake_intensity = 10
	await get_tree().physics_frame
	await get_tree().physics_frame
	for a in area.get_overlapping_bodies():
		if a.is_in_group("player"):
			a.die()
		print(a.name)
	$Foot/CollisionShape2D.disabled = false
					
	await get_tree().create_timer(foot_on_ground_time).timeout
	foot_texture.visible = false
	$Foot/CollisionShape2D.disabled = true
