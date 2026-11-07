extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.logo:
		visible = false
	else:
		Global.logo = true
		hide_logo()

# Called every frame.dawww d wawa w 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func hide_logo():
	await get_tree().create_timer(3).timeout
	var t = create_tween()
	t.tween_property($".","modulate",Color(1.0, 1.0, 1.0, 0.0),1)
