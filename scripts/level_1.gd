extends Node2D

func _ready() -> void:
	await $CanvasLayer/AnimationTree.animation_finished
	if "The Start Of a Journey" not in AchievementState.completed:
		$Player/Achievements.completed_achievement("The Start Of a Journey")
		
