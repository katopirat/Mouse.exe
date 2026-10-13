extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.music_style != "boss":
		Global.music_style = "boss"
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
