extends Button

@export var scene:PackedScene

func _ready() -> void:
	pressed.connect(_on_pressed)

func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	get_tree().change_scene_to_packed(scene)
