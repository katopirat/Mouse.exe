extends PanelContainer
@export var text : String
@export var icon : Texture2D
@export var min_time : float = 0.015
@export var max_time : float = 0.02
@export var start : bool
@onready var label = $HBoxContainer/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/Panel.texture = icon
	start = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if start :
		write()
		start = false

func write():
	var text_z :String
	for a in text :
		await get_tree().create_timer(randf_range(min_time,max_time)).timeout
		text_z += a
		label.text = text_z
		
