extends Node2D
@export var music = "chill"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.music_style != music:
		Global.music_style = music
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
