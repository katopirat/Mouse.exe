extends Area2D

var cursor_inside = false
var is_pressed = false

@onready var sound_player = $AudioStreamPlayer
@onready var button = $Button

signal pressed()

func _ready() -> void:
	add_to_group("clickable")
	button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	button.self_modulate = Color(1.0, 1.0, 1.0)
	body_entered.connect(_on_any_entered)
	body_exited.connect(_on_any_exited)
	area_entered.connect(_on_any_entered)
	area_exited.connect(_on_any_exited)

func _is_cursor(node: Node) -> bool:
	if not node:
		return false
	if node.name == "Cursor" or node.name == "Hitbox" or node.is_in_group("cursor"):
		return true
	var parent = node.get_parent()
	return parent != null and (parent.name == "Cursor" or parent.is_in_group("cursor"))

func _on_any_entered(node: Node) -> void:
	if _is_cursor(node):
		cursor_inside = true
		_update_visuals()

func _on_any_exited(node: Node) -> void:
	if _is_cursor(node):
		cursor_inside = false
		_update_visuals()

func _update_visuals() -> void:
	if is_pressed:
		return
	
	if cursor_inside:
		button.self_modulate = Color(1.3, 1.3, 1.3)
	else:
		button.self_modulate = Color(1.0, 1.0, 1.0)

func _input(event: InputEvent) -> void:
	var is_click = event.is_action_pressed("click") if InputMap.has_action("click") else false
	var is_mouse_click = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed

	if cursor_inside and (is_click or is_mouse_click):
		if not is_pressed:
			is_pressed = true
			pressed.emit()
			if sound_player:
				sound_player.play()
			button.self_modulate = Color(0.4, 0.4, 0.4)
			
			monitoring = false
			monitorable = false
			cursor_inside = false

func reset() -> void:
	is_pressed = false
	monitoring = true
	monitorable = true
	cursor_inside = false
	button.self_modulate = Color(1.0, 1.0, 1.0)
