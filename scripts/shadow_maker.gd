extends StaticBody2D
@export var height: float = 2
@export var shadow_color: Color = Color(0, 0, 0, 0.5) 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sprite = $Sprite2D
	
	var shadow = Sprite2D.new()
	shadow.texture = sprite.texture
	
	shadow.modulate = shadow_color
	
	shadow.scale.x = sprite.scale.x
	shadow.scale.y = sprite.scale.y * 0.6
	
	shadow.position = Vector2(height*0.5, height)
	
	shadow.z_index = sprite.z_index - 1 
	
	add_child(shadow)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
