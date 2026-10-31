extends Node2D
@onready var pop_up = $PopUp
@onready var sound = $AudioStreamPlayer


func completed_achievement(achievement_name: String) -> void:

	if achievement_name not in AchievementState.completed:
		print("completed: ", achievement_name)
		sound.play()
		AchievementState.completed.append(achievement_name)
		pop_up.play_achievement(achievement_name)
