extends Area2D
@onready var cursor_inside: bool = false
signal cookie_clicked()
func _ready() -> void:
	add_to_group("clickable")
func _input(event):
	
	if event.is_action_pressed("click") and Global.player_can_move and self == Global.highest_clickable_body:
		cookie_clicked.emit()
