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
@onready var dialog = $"../CanvasLayer/DialogWindow"
var foot_hp = 3
var hit_cooldown = false
@onready var hp_bar = $"../CanvasLayer/ProgressBar"

func _ready() -> void:
	Global.music_style = "boss"
	remove_child(foot)
	await intro()
	hp_bar.max_value = foot_hp
	hp_bar.value = foot_hp
	hp_bar.modulate.a = 0.0
	hp_bar.visible = true
	create_tween().tween_property(hp_bar, "modulate:a", 1.0, 0.5)
	main_loop()
	
func wait(time: float):
	await get_tree().create_timer(time).timeout
func main_loop():
	while foot_hp > 0:
		add_child(foot)
		for s in range(randi_range(2, 4)):
			await funkce_ktera_dela_to_ze_noha_dupne_na_mys()
			if foot_hp <= 0:
				return
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

func say(icon,line):
	dialog.text = line
	dialog.icon = load(icon)
	dialog.start = true
	await  dialog.window_closed
	
func intro():
	if "foot" in GameState.boss:
		return
	Global.player_can_move = false
	
	add_child(foot)
	$Foot/CollisionShape2D.disabled = true
	foot_texture.visible = false
	shadow_texture.visible = true
	shadow_texture.modulate = Color(0.0,0.0,0.0,0.588)
	shadow_texture.material.set_shader_parameter("color", Color(0.0, 0.0, 0.0, 1.0))
	shadow_texture.scale = default_size * 0.2
	foot.global_position = player.global_position
	
	var t = create_tween()
	t.tween_property(shadow_texture,"scale",default_size * 1.2,1.5)
	await t.finished
	camera.shake_intensity = 5

	await say("res://assets/images/hand_icon.png", "20 MOUSEPADS? ON MY CARD!")
	await say("res://assets/images/mouse_stacionary_small.png", "They were on sale.")
	await say("res://assets/images/hand_icon.png", "HOLD STILL.")
	await say("res://assets/images/mouse_stacionary_small.png", "Ok i need to get rid of him i need to run around his foot, wrap the cable and pull it tight.")
	
	var t2 = create_tween()
	t2.tween_property(shadow_texture,"scale",default_size*1.5,0.4)
	await t2.finished
	camera.shake_intensity = 10
	
	
	remove_child(foot)
	GameState.boss.append("foot")
	Global.player_can_move = true

func tied():
	if hit_cooldown or foot_hp <= 0 or $Foot/CollisionShape2D.disabled:
		return
	hit_cooldown = true
	foot_hp -= 1
	create_tween().tween_property(hp_bar, "value", foot_hp, 0.3)
	camera.shake_intensity = 25
	blood(foot.global_position, 80, 1.0)
	if foot_hp <= 0:
		die_foot()
		return
	await wait(1.5)
	hit_cooldown = false
	
func die_foot():
	
	$Foot/CollisionShape2D.disabled = true
	for i in 8:
		blood(foot.global_position + Vector2(randf_range(-200, 200), randf_range(-200, 200)), 150, 1.5)
		camera.shake_intensity = 40
		await  wait(0.15)
	foot.visible = false
	hp_bar.visible = false
	Global.player_can_move = false
	await say("res://assets/images/hand_icon.png", "...FINE. KEEP THEM.")
	Global.player_can_move = true
	$"../Niceson".visible = false
	$"../Niceson".queue_free()
	

func blood(pos: Vector2, amount: int, size: float):
	var p = CPUParticles2D.new()
	add_child(p)
	p.global_position = pos
	p.z_index = 20
	p.one_shot = true
	p.explosiveness = 1.0
	p.amount = amount
	p.lifetime = 1.5
	p.direction = Vector2(0, -1)
	p.spread = 180
	p.initial_velocity_min = 300 * size
	p.initial_velocity_max = 1200 * size
	p.gravity = Vector2(0, 1500)
	p.scale_amount_min = 4 * size
	p.scale_amount_max = 14 * size
	p.color = Color(0.7, 0.0, 0.0)
	p.emitting = true
	get_tree().create_timer(3.0).timeout.connect(p.queue_free)
	
	
