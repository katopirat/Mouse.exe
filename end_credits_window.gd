extends Node2D
@export var start = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.visible_ratio = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start == true:
		await text()
		
		
func text():
	$Label.visible_ratio = 0
	var t = create_tween()
	t.set_trans(Tween.TRANS_SINE)
	t.set_ease(Tween.EASE_IN_OUT)
	
	t.tween_property($Label,"visible_ratio",1.0,0.5)
	
	
