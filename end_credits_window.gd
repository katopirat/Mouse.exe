extends Node2D
@export var start = false
@export var to_menu = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_tree().current_scene)
	$Label.visible_ratio = 0
	to_menu = false
	start = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start == true:
		await text()
	if to_menu == true:
		GameState.go_to_menu()
		
		
func text():
	$Label.visible_ratio = 0
	var t = create_tween()


	
	t.tween_property($Label,"visible_ratio",1.0,1.7)
	
	
