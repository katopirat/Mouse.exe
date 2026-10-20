extends AnimatableBody2D

@onready var camera = $"../../Player/Camera2D"
var shake 

@onready var asprite = $AnimatedSprite2D
@onready var sf = asprite.sprite_frames



var start = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var texture = sf.get_frame_texture(asprite.animation, asprite.frame)
	if texture != null:
		if texture.resource_path .get_file() == "Emo(walk)1.png": start = 1
		if  texture.resource_path .get_file() == "Emo(walk)1.png":
			$Right.emitting = true
		elif texture.resource_path .get_file() == "Emo(walk)2.png":
			$Left.emitting = true

	
	
	if start == 1:
		shake = (800 - global_position.distance_to(camera.global_position))/80
		if shake >= 0:
			camera.start_shake(shake,10)
