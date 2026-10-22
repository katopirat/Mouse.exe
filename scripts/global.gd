extends Node


var player_can_move: bool = true
var music_style: String = "chill"
var highest_clickable_body: Area2D
var achievements_scene = preload("res://achievements.tscn").instantiate()
