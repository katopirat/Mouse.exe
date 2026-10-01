extends Control

func _ready():
	visible = false
func pouse():
	var tung_tung_sahur = !get_tree().paused
	get_tree().paused = tung_tung_sahur
	visible = tung_tung_sahur

func _input(event:InputEvent):


	if event.is_action_pressed("esc"):
		pouse()
		
