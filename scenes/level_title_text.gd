extends RichTextLabel

func _ready() -> void:
	var path = get_tree().current_scene.scene_file_path
	print(str(path))
	for lvl in GameState.levels:
		if lvl["scene"] == path: 
			text = "lvl " + str(GameState.levels.find(lvl) + 1) + ":\n" + lvl["name"]
			print("true")
			break



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
