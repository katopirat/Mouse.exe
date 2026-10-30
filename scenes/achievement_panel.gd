extends PanelContainer
@onready var icon = $HBoxContainer/PanelContainer/AchievemntIcon 
@onready var lock = $HBoxContainer/PanelContainer/Lock
@onready var title = $HBoxContainer/VBoxContainer/Title
@onready var description = $HBoxContainer/VBoxContainer/Description


func unlock( ):
	$HBoxContainer/PanelContainer/Lock.visible = false
	$HBoxContainer/PanelContainer/AchievemntIcon.modulate = Color(1.0, 1.0, 1.0, 1.0)
var unlocked = false 
func setup(title_text,description_text,unlocked,icon_path):
	title.text = str(title_text)
	description.text = str(description_text)
	if ResourceLoader.exists(icon_path):
		icon.texture = load(icon_path)
	if unlocked :
		unlock()
	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
