extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sound_effect: AudioStreamPlayer = $AudioStreamPlayer
@export var next_scene: PackedScene 
@onready var player: CharacterBody2D = get_tree().get_nodes_in_group("player")[0]



signal get_mouse_to_finish(pos: Vector2)
var level_time = 0
var timer_start = 0
var p_position: Vector2


func level_completed():
	var path = get_tree().current_scene.scene_file_path
	var level = null
	for i in range(GameState.levels.size()):
		if GameState.levels[i]["scene"] == path:
			level = i
			break
	print(level)
	print(GameState.levels.size())
	if level != null and level + 1 < GameState.levels.size():
		GameState.go_to_level(level + 1)
	else:
		print("menu")
		GameState.go_to_menu()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print ("you are in finish")
		Global.player_can_move = false
		GameState.finish_level((Time.get_ticks_msec() - timer_start) / 1000.0)
		sound_effect.play()
		get_mouse_to_finish.emit(global_position)
		await body.animation_finished
		print('called')
		level_completed()

func _ready() -> void:
	p_position = player.position
	

func _process(delta: float) -> void:
	if timer_start == 0:
		if player.position != p_position:
			timer_start = Time.get_ticks_msec()
			
			
