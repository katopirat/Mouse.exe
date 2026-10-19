extends Node

@export var audio_player: AudioStreamPlayer
@export var phrase_to_play: String
@export var sounds: Dictionary[String, AudioStream] = {
	"a": null,
	"e": null,
	"i": null,
	"o": null,
	"u": null}

@onready var sounds_dictionary: Dictionary = {
	"a": "a",
	"ee": "i",
	"e": "e",
	"oo": "u",
	"u": "a",
	"i": "ai",
	"y": "ai",
	"ie": "ai",
	"o": "o"
}
@onready var waiting_time: Dictionary = {
	"a": 0.1,
	"e": 0.1,
	"u": 0.15,
	"i": 0.15,
	"o": 0.1,
	" ": 0.2,
	",": 0.7,
	", ": 0.7,
	".": 1,
	"!": 1,
	"?": 1,
	"...": 1.2
}
func _ready() -> void:
	await get_tree().create_timer(2).timeout
	play_phrase(phrase_to_play)
func play_sound(sound: String):
	print(sound)
	if sound in sounds_dictionary:
		var all_sounds = sounds_dictionary[sound].split("")
		for s in all_sounds:
			audio_player.stream = sounds[s]
			audio_player.play()
			await get_tree().create_timer(waiting_time[s]).timeout
			return
	else:
		if sound in waiting_time:
			await get_tree().create_timer(waiting_time[sound]).timeout
		return	
func play_phrase(phrase: String):
	var parsed_phrase = phrase.split("")
	var counter = 0
	while counter < parsed_phrase.size():
		if counter != parsed_phrase.size()-1 and parsed_phrase[counter]+parsed_phrase[counter+1] in sounds_dictionary:
			await play_sound(parsed_phrase[counter]+parsed_phrase[counter+1])
			counter += 1
		elif parsed_phrase[counter] in sounds_dictionary or parsed_phrase[counter] in waiting_time:
			await play_sound(parsed_phrase[counter])
		counter += 1
