extends Control
@onready var s_container = $PanelContainer/VBoxContainer/ScrollContainer
@onready var achievemet_scene : PackedScene = preload("res://scenes/achievement_panel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	refresh()


# Called every frame. 'delta' is the elapsed time since the previous frame. 8u  
func _process(delta: float) -> void:
	pass

func show_window():
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	refresh()
	
func refresh():
	print("refresh")
	for child in s_container.get_children():
		child.queue_free()
	
	for a in AchievementState.achievements:
		print(a)
		print(AchievementState.achievements[a])
		
		var unlocked = a in AchievementState.completed
		var achivemet_panel = achievemet_scene.instantiate()
		s_container.add_child(achivemet_panel)
		print(unlocked)
		print("res://achievements_textures/"+a+".png")
		achivemet_panel.setup(a,AchievementState.achievements[a],unlocked,"res://achievements_textures/"+a+".png")
		
		
	
