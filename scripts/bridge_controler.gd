extends Node

@export var table : TileSet
@export var bridge : TileSet
@export var button : Button

func _ready() -> void:
	button.pressed.connect(open_bridge)
	bridge.visible = false
	table

func open_bridge() -> void:
	
	
