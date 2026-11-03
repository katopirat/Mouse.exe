extends Node2D

@onready var shadow = $Shadow
@onready var hand = $Hand
@onready var area = $Hand/Area2D
@onready var camera = $Node2D/Player/Camera2D

@onready var warning1 = $Warning1
@onready var warning2 = $Warning2
@onready var fist1 = $Fist1
@onready var fist2 = $Fist2

@onready var add_button = $Node2D/Player/Monitor_2/Computer/Window/Control/PanelContainer/VBoxContainer/PanelContainer/Add_to_cart
@onready var shop_label = $Node2D/Player/Monitor_2/Computer/Window/Control/PanelContainer/VBoxContainer/PanelContainer/Label2

var punch_time = 1.5

var intro_process = 0
var player
var mouse_pads = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	shadow.visible = false

	await intro()

	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start():
	
	Global.music_style = "boss"
	await get_tree().create_timer(3)
	change_button_position()
	if player.god_mode == true:
		mouse_pads = 14
	while mouse_pads < 20:
		if randi_range(0,1) == 1:
			await funkce_ktera_dela_to_ze_ruka_placne_mys()
		else:
			await punch()
		await get_tree().create_timer(1.0).timeout
		if mouse_pads >= 15:
			punch_time = 1.0 

		
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
	t.tween_property(warning1,"modulate",Color(1.0, 0.0, 0.122, 0.784),punch_time)
	t.tween_property(warning2,"modulate",Color(1.0, 0.0, 0.122, 0.784),punch_time)
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
		

func intro():

	if GameState.boss >= 2:
		mouse_pads = 1
		shop_label.text = "1/20"
		start()
		return
	add_button.position = Vector2(10000,1000)
	add_button.visible = false
	Global.player_can_move = false
	$Node2D/CanvasLayer/DialogWindow.start = true
	await $Node2D/CanvasLayer/DialogWindow.window_closed
	add_button.position = Vector2(152.0,104.0)
	add_button.visible = true
	await add_button.pressed
	shop_label.text = "1/20"
	mouse_pads = 1
	
	hand.visible = true
	hand.position = player.global_position + Vector2(1000, 700)
	var t = create_tween()
	t.set_trans(Tween.TRANS_SINE)
	t.set_ease(Tween.EASE_IN_OUT)
	t.tween_property(hand, "global_position", player.global_position + Vector2(120, 501), 2)
	$Node2D/CanvasLayer/DialogWindow.text = "HEY?! WHO IS BUYING THIS?"
	$Node2D/CanvasLayer/DialogWindow.icon = load("res://assets/images/hand_icon.png")
	$Node2D/CanvasLayer/DialogWindow.start = true
	await $Node2D/CanvasLayer/DialogWindow.window_closed
	
	$Node2D/CanvasLayer/DialogWindow.text = "I need to buy all the mousepads as quickly as possible!"
	$Node2D/CanvasLayer/DialogWindow.icon = load("res://assets/images/mouse_stacionary_small.png")
	$Node2D/CanvasLayer/DialogWindow.start = true
	await $Node2D/CanvasLayer/DialogWindow.window_closed
	
	var tw = create_tween()
	tw.tween_property(hand, "global_position", player.global_position + Vector2(1000, 700), 2)
	
	await  tw.finished
	hand.visible = false
	GameState.boss = 2
	start()

func change_button_position():
	while mouse_pads <= 20:
		if randi_range(0,1) == 1:
			add_button.position = Vector2(randf_range(145.0,321),randf_range(40,157))
		else:
			add_button.position = Vector2(randf_range(5.0,65.0),randf_range(142.0,158.0))
		if mouse_pads < 20:
			add_button.reset()
			await add_button.pressed
			mouse_pads += 1
			shop_label.text = str(mouse_pads) + "/20"
			await get_tree().create_timer(0.1).timeout
		else:
			break
	add_button.position = Vector2(randf_range(145.0,321),randf_range(40,157))
	add_button.reset()
	add_button.get_child(1).text = "  pay now  "
	add_button.get_child(2).text = "pay 598$"
	add_button.scale = Vector2(2.5,2.5)
	await add_button.pressed
	hand.visible = true
	var t = create_tween()
	
	t.set_trans(Tween.TRANS_SINE)
	t.set_ease(Tween.EASE_IN_OUT)
	t.tween_property(hand, "global_position", player.global_position + Vector2(120, 501), 2)
	
	$Node2D/CanvasLayer/DialogWindow.text = "nooo why did u do that"
	$Node2D/CanvasLayer/DialogWindow.icon = load("res://assets/images/hand_icon.png")
	$Node2D/CanvasLayer/DialogWindow.start = true
	await $Node2D/CanvasLayer/DialogWindow.window_closed

	$Node2D/CanvasLayer/DialogWindow.text = "I need to find the exit"
	$Node2D/CanvasLayer/DialogWindow.icon = load("res://assets/images/mouse_stacionary_small.png")
	$Node2D/CanvasLayer/DialogWindow.start = true
	await $Node2D/CanvasLayer/DialogWindow.window_closed
	
	$Node2D/Table._on_bridge_button_open_bridge()
