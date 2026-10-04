extends Node2D

const CACTUSES: Array[PackedScene] = [
	preload("res://scenes/dino_game/dino_cactus.tscn"),
	preload("res://scenes/dino_game/dino_cactus_small.tscn"),
	preload("res://scenes/dino_game/dino_cactus_small_2.tscn"),
	preload("res://scenes/dino_game/dino_cactus_small_3.tscn")
]


@onready var label: Label = $Label
@onready var timer: Timer = $Timer

var score: int = 0

	
	


func start_game() -> void:
	timer.timeout.connect(_on_spawn_timer_timeout)
	_update_score_ui()
	score = 0
	_update_score_ui()
	timer.wait_time = randf_range(1.2, 2.5)
	timer.start()

func _on_spawn_timer_timeout() -> void:
	var random_scene: PackedScene = CACTUSES.pick_random()
	var cactus = random_scene.instantiate()
	cactus.position = Vector2(325.714, 171.429)
	cactus.score_awarded.connect(_on_cactus_passed)
	add_child(cactus)
	timer.wait_time = randf_range(1.2, 2.5)
	

func _on_cactus_passed() -> void:
	score += 1
	_update_score_ui()

func _update_score_ui() -> void:
	label.text = str(score) + "/10"
	if score >= 10:
		$"../../../../../Finish".level_completed()
