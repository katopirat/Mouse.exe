extends Area2D
var cursor_inside = false
var is_pressed = 0
@onready var game_window = $"../Window"

func _ready() -> void:
	$"..".remove_child.call_deferred(game_window)
	$Sprite2D.play('default')
	add_to_group("clickable")

 
func _process(delta: float) -> void:
	if self == Global.highest_clickable_body:
		cursor_inside = true
	else:
		cursor_inside = false

func _input(event):
	if event.is_action_pressed("click"):
		if cursor_inside:
			if is_pressed == 0:
				is_pressed = 1
				$Sprite2D.play("clicked")
			elif is_pressed == 1:
				is_pressed = 2
				$"..".add_child(game_window)
				queue_free()
				
		else:
			is_pressed = 0
			$Sprite2D.play('default')
