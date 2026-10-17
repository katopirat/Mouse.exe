extends Area2D
@onready var cursor_inside = false
@onready var pressed: bool = false
@onready var viewport = $"../../SubViewportContainer/SubViewport"
func _ready() -> void:
	add_to_group("clickable")

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Cursor":
		cursor_inside = true
		
 
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Cursor":
		cursor_inside = false
		
func _process(delta: float) -> void:
	if cursor_inside and Input.is_action_pressed("click") and Global.player_can_move and self == Global.highest_clickable_body:
		if not pressed:
			click(true)
		pressed = true
	elif pressed:
		pressed = false
		click(false)
func click(pressed):
	
	var event = InputEventAction.new()
	event.action = "button_click"
	event.pressed = pressed
	print(event)
	viewport.push_input(event, true)
