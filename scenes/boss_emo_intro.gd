extends Sprite2D
@export var animation_play: String = "default"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var old
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if animation_play != old:
		$Sprite2D.play(animation_play)
	old = animation_play
