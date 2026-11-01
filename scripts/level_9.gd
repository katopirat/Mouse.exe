extends Node2D




func _on_bridge_button_open_bridge() -> void:
	$Node2D/Player/Achievements.completed_achievement("Precision Master")
