extends Sprite2D

var puvodni_texture
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	puvodni_texture = texture

func _input(event):
	if event is InputEventMouseButton:
		
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				texture = preload("res://assets/images/Myš¡(left-click).png")
			else:
					texture = puvodni_texture
			
		elif event.button_index == MOUSE_BUTTON_RIGHT:
				if event.pressed:
					texture = preload("res://assets/images/MyÅ¡(right-click).png")
				else:
					texture = puvodni_texture





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
