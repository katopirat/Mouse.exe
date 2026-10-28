extends Node


@onready var completed = []

@onready var achievements: Dictionary[String, String] = {
	"Button Masher": "Click a button 20 times in one level.",
	"The Start Of a Journey": "Complete the first level.",
	"Stonks!": "Get $5 000 in the bitcoin level."
	}
