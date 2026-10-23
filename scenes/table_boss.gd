extends Node2D

@onready var shadow = $Shadow
@onready var hand = $Hand
@onready var area = $Hand/Area2D
@onready var camera = $Node2D/Player/Camera2D

@onready var warning1 = $Warning1
@onready var warning2 = $Warning2
@onready var fist1 = $Fist1
@onready var fist2 = $Fist2

var player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	hand 
	shadow.visible = false
	await get_tree().create_timer(1.0).timeout
	start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start():
	while true:
		if randi_range(0,1) == 1:
			await funkce_ktera_dela_to_ze_ruka_placne_mys()
		else:
			await punch()
		await get_tree().create_timer(1.0).timeout
		
func funkce_ktera_dela_to_ze_ruka_placne_mys():
	$Hand/StaticBody2D/CollisionShape2D.disabled = true
	shadow.scale = Vector2(6.0,6.0)
	hand.visible = false
	shadow.visible = true
	shadow.modulate = Color(0.0, 0.0, 0.0, 0.588)
	shadow.material.set_shader_parameter("color",Color(0.0, 0.0, 0.0, 1.0))
	
	for i in 60 :
		shadow.global_position = shadow.global_position.lerp(player.global_position, 0.1)
		await get_tree().process_frame
	var t = create_tween().set_parallel(true)
	t.tween_property(shadow,"material:shader_parameter/color",Color(0.6, 0.0, 0.0),0.4)
	t.tween_property(shadow,"scale",Vector2(5,5),0.4)
	await get_tree().create_timer(0.4).timeout
	
	hand.position = shadow.position + Vector2(0,501.0)
	hand.scale = Vector2(7.0,7.0)
	hand.visible = true
	
	var tw = create_tween().set_parallel(true)
	tw.tween_property(hand,"scale",Vector2(3.0,3.0),0.1)
	tw.tween_property(shadow,"scale",Vector2(2.0,2.0),0.1)
	await get_tree().create_timer(0.1).timeout
	
	shadow.visible = false 
	
	camera.shake_intensity = 10
	await get_tree().physics_frame
	await get_tree().physics_frame
	for a in area.get_overlapping_bodies():
		if a.is_in_group("player"):
			a.die()
		print(a.name)
	$Hand/StaticBody2D/CollisionShape2D.disabled = false
			
	await get_tree().create_timer(2.0).timeout
	hand.visible = false
	$Hand/StaticBody2D/CollisionShape2D.disabled = true
	
func  punch():
	var y1 = player.global_position.y
	var y2 = randf_range(-739.0,1177.0)
	warning1.global_position = Vector2(3533.0,y1)
	warning2.global_position = Vector2(3533.0,y2)
	
	
	warning1.modulate = Color(0.0, 0.0, 0.0, 0.0)
	warning2.modulate = Color(0.0, 0.0, 0.0, 0.0)
	warning1.visible = true
	warning2.visible = true
	var t = create_tween().set_parallel()
	t.tween_property(warning1,"modulate",Color(1.0, 0.0, 0.122, 0.784),0.7)
	t.tween_property(warning2,"modulate",Color(1.0, 0.0, 0.122, 0.784),0.7)
	await t.finished
	await get_tree().create_timer(0.1).timeout
	
	warning1.visible = false
	warning2.visible = false
	
	fist1.global_position = Vector2(-1464.0, y1)
	fist2.global_position = Vector2(1965.0, y2)
	fist1.visible = true
	fist2.visible = true
	camera.shake_intensity = 10
	
	var tw = create_tween().set_parallel(true)
	tw.tween_property(fist1, "global_position:x", 1965.0, 0.5)
	tw.tween_property(fist2, "global_position:x", -1464.0, 0.5)
	
	await tw.finished
	fist1.visible = false
	fist2.visible = false


func _on_area_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.knockback(Vector2(1, 0))



func _on_area_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.knockback(Vector2(-1, 0))
