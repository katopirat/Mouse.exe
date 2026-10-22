extends Node2D

@onready var shadow = $Shadow
@onready var hand = $Hand
@onready var area = $Hand/Area2D
@onready var camera = $Node2D/Player/Camera2D
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
		await funkce_ktera_dela_to_ze_ruka_placne_mys()
		
func funkce_ktera_dela_to_ze_ruka_placne_mys():
	shadow.visible = true
	shadow.modulate = Color(0.0, 0.0, 0.0, 0.588)
	
	for i in 60 :
		shadow.global_position = shadow.global_position.lerp(player.global_position, 0.1)
		await get_tree().process_frame
	await get_tree().create_timer(0.5).timeout
	
	shadow.modulate = Color(0.6, 0.0, 0.0)
	hand.position = shadow.position + Vector2(0,501.0)
	hand.visible = true
	shadow.visible = false 
	camera.shake_intensity = 10
	await get_tree().physics_frame
	await get_tree().physics_frame
	for a in area.get_overlapping_bodies():
		if a.is_in_group("player"):
			a.die()
		print(a.name)
	
			
	await get_tree().create_timer(2.0).timeout
	hand.visible = false
	


	
