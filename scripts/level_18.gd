extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await $CanvasLayer/AnimationTree.animation_finished
	if GameState.best_times[18] < 50:
		$Player/Achievements.completed_achievement("Gotta Go Fast")
