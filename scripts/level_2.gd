extends Node2D


@onready var ads_closed = 0


func _on_x_button_ad_closed() -> void:
	ads_closed += 1
	if ads_closed == 6:
		$Node2D/Player/Achievements.completed_achievement("Ad Blocker")
