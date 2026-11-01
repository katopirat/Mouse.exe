extends Node2D





func _on_x_button_ad_closed() -> void:
	$Node2D/Player/Achievements.completed_achievement("Fell For It")
