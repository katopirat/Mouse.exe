extends Node

@export var audio_player: AudioStreamPlayer
@export var phrases_to_play: Array[String]
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
	"o": "o",
	"ou": "u"
}
@onready var waiting_time: Dictionary = {
	"a": 0.07,
	"e": 0.07,
	"u": 0.1,
	"i": 0.1,
	"o": 0.07,
	" ": 0.02,
	",": 0.7,
	", ": 0.7,
	".": 1,
	"!": 1,
	"?": 1,
	"...": 1.2
}
func _ready() -> void:
	await get_tree().create_timer(2).timeout
	for p in phrases_to_play:
		await play_phrase(p)

func play_sound(sound: String, pitch_to_play):
	if sound in sounds_dictionary:
		var all_sounds = sounds_dictionary[sound].split("")
		for s in all_sounds:
			audio_player.stream = sounds[s]
			audio_player.pitch_scale = pitch_to_play
			audio_player.play()
			await get_tree().create_timer(waiting_time[s]).timeout
			return
	else:
		if sound in waiting_time:
			await get_tree().create_timer(waiting_time[sound]).timeout
		return	
func play_phrase(phrase: String):
	
	var pitch = 1
	var parsed_phrase = phrase.to_lower().split("")
	var counter = 0
	while counter < parsed_phrase.size():
		var letters_to_say: String
		if counter != parsed_phrase.size()-1:
			letters_to_say = parsed_phrase[counter]+parsed_phrase[counter+1]
		else:
			letters_to_say = parsed_phrase[counter]
		print(letters_to_say)
		if parsed_phrase[-1] == "?" and counter > parsed_phrase.size() - len(phrase.split(" ")[-1]):
			pitch *= 1.07
		else:
			pitch /= 1.01
		if letters_to_say in sounds_dictionary:
			print(2)
			await play_sound(letters_to_say, pitch)
			counter += 1
		elif parsed_phrase[counter] in sounds_dictionary or parsed_phrase[counter] in waiting_time:
			print(1)
			await play_sound(parsed_phrase[counter], pitch)
		counter += 1
