extends Node


@onready var completed 

@onready var achievements: Dictionary[String, String] = {
	"Button Masher": "Click a button 20 times in one level.",
	"The Start Of a Journey": "Complete the first level.",
	"Stonks!": "Get $10 000 in the bitcoin level.",
	"To Jsou Ty Windousy": "Crash Biscuit Clicker.",
	"Ad Blocker": "Close all ads in level 3.",
	"Fell For It": "Uncover the wrong button in level 8.",
	"Precision Master": "Press the tiny button in level 9."
	}
