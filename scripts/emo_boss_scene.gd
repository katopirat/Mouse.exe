extends Node2D
const intro = "res://scenes/emo_boss_intro.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(GameState.boss)
	if !"emo" in GameState.boss :
		print("ok")
		GameState.boss.append("emo")
		get_tree().call_deferred("change_scene_to_file", intro)
		
	if Global.music_style != "boss":
		Global.music_style = "boss"
		

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
