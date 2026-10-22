extends Node2D
@onready var pop_up = $PopUp


func completed_achievement(achievement_name: String) -> void:

	if achievement_name not in AchievementState.completed:
		print("completed: ", achievement_name)
		AchievementState.completed.append(achievement_name)
		pop_up.play_achievement(achievement_name)
