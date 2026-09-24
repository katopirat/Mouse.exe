extends Node2D

signal table_changed(new_tilemap)

@export var tilemap_1: TileMap
@export var tilemap_2: TileMap
@export var tilemap_dotted_1: TileMap
@export var tilemap_dotted_2: TileMap

func _ready() -> void:
	remove_child(tilemap_2)
	remove_child(tilemap_dotted_2)
	table_changed.emit(tilemap_1)


func _on_bridge_button_open_bridge() -> void:
	if tilemap_1.get_parent() != null:
		remove_child(tilemap_1)
	if tilemap_dotted_1.get_parent() != null:
		remove_child(tilemap_dotted_1)
	if tilemap_2.get_parent() == null:
		add_child(tilemap_2)
		table_changed.emit(tilemap_2)
	if tilemap_dotted_2.get_parent() == null:
		add_child(tilemap_dotted_2)

func _on_bridge_button_close_bridge() -> void:
	if tilemap_2.get_parent() != null:
		remove_child(tilemap_2)
	if tilemap_dotted_2.get_parent() != null:
		remove_child(tilemap_dotted_2)
	if tilemap_1.get_parent() == null:
		add_child(tilemap_1)
		table_changed.emit(tilemap_1)
	if tilemap_dotted_1.get_parent() == null:
		add_child(tilemap_dotted_1)
