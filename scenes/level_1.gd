extends Node2D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

@export var playlist: Array[AudioStream] = []

var current_track_index: int = 0

func _ready() -> void:
	if playlist.size() > 0:
		play_track(current_track_index)
	else:
		push_warning("Playlist is empty! Drag some MP3s into the Inspector.")

func play_track(index: int) -> void:
	audio_player.stream = playlist[index]
	audio_player.play()
	print("Now playing track index: ", index)

func _on_audio_stream_player_finished() -> void:
	current_track_index = (current_track_index + 1) % playlist.size()
	
	play_track(current_track_index)
