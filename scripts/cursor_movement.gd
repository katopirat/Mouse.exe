extends CharacterBody2D

@export var speed: float = 20.0
@onready var cursor_type: int = 0
func _ready() -> void:
	if has_node("Arrow"):
		$Arrow.visible = true
	if has_node("Hand"):
		$Hand.visible = false

func _on_player_moved_mouse(dir: Variant) -> void:
	velocity = dir * speed
	move_and_slide()
	var overlapping_areas: Array[Area2D] = $Hitbox.get_overlapping_areas()
	var highest_click = null
	for b in overlapping_areas:
		if highest_click == null or b.is_greater_than(highest_click):
			highest_click = b
	Global.highest_clickable_body = highest_click
func set_click_mode(mode) -> void:
	if mode == "hand":
		cursor_type += 1
	elif mode == "arrow":
		cursor_type -= 1
	if has_node("Arrow") and has_node("Hand"):
		if cursor_type > 0:
			$Hand.visible = true
			$Arrow.visible = false
		else: 
			$Hand.visible = false
			$Arrow.visible = true
