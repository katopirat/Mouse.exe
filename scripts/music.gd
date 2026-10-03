extends Node2D

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

#Different style playlists
@export var chill_playlist: Array[AudioStream] = []
@export var dramatic_playlist: Array[AudioStream] = []
@export var other_playlist: Array[AudioStream] = []


@export_enum("chill", "dramatic") var current_style: String = 'chill'

@onready var playlist: Array[AudioStream] = chill_playlist
@onready var songs_len: int = playlist.size()
@onready var current_track_index: int = randi_range(0, songs_len-1)
	
func get_playlist(style: String):
	
	if style == 'chill':
		return chill_playlist
	elif style == 'dramatic':
		return dramatic_playlist
	else:
		return other_playlist 
	
		
func _ready() -> void:
	randomize()
	
	if playlist.size() > 0:
		play_track(current_track_index)

func play_track(index: int) -> void:
	audio_player.stream = playlist[index]
	audio_player.play()
	print("Now playing track index: ", index)

func _on_audio_stream_player_finished() -> void:
	var new_track_index = current_track_index
	while new_track_index == current_track_index:
		new_track_index = randi_range(0, songs_len-1)
	current_track_index = new_track_index
	
	play_track(current_track_index)
