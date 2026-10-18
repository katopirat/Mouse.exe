extends CharacterBody2D

@export var speed: float = 20.0
func _ready() -> void:
	if has_node("Arrow"):
		$Arrow.visible = true
	if has_node("Hand"):
		$Hand.visible = false
	if has_node("Dont"):
		$Dont.visible = false
func _process(delta: float) -> void:
	var body_to_click = Global.highest_clickable_body
	if body_to_click:
		if body_to_click.is_in_group("clickable"):
			set_click_mode("hand")
		elif body_to_click.is_in_group("ads"):
			set_click_mode("dont")
		else:
			set_click_mode("arrow")
	else:
		set_click_mode('arrow')
func _on_player_moved_mouse(dir: Variant) -> void:
	velocity = dir * speed
	move_and_slide()
	var overlapping_areas: Array[Area2D] = $Hitbox.get_overlapping_areas()
	var highest_click = null
	for b in overlapping_areas:
		if highest_click == null or b.is_greater_than(highest_click):
			highest_click = b
func set_click_mode(mode) -> void:
	if has_node("Arrow") and has_node("Hand") and has_node("Dont"):
		if mode == "hand":
			$Hand.visible = true
			$Arrow.visible = false
			$Dont.visible = false
		elif mode == 'dont':
			$Hand.visible = false
			$Arrow.visible = false
			$Dont.visible = true
		else: 
			$Hand.visible = false
			$Arrow.visible = true
			$Dont.visible = false
