extends Node2D
const cut_scene = "res://scenes/cut scene fall.tscn"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(GameState.boss)
	if !"table" in GameState.boss :
		GameState.boss.append("table") 
		get_tree().call_deferred("change_scene_to_file", cut_scene)
		
	#	if Global.music_style != "boss":
#		Global.music_style = "boss"
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
