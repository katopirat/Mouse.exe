extends Control

func _ready():
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func pouse():
	var tung_tung_sahur = !get_tree().paused
	get_tree().paused = tung_tung_sahur
	visible = tung_tung_sahur
	if tung_tung_sahur == true:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func _input(event:InputEvent):


	if event.is_action_pressed("esc"):
		pouse()
		
