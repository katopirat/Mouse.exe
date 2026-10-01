extends Control

@onready var grid = $Window/VBoxContainer/GridContainer
@onready var info = $Window/VBoxContainer/Info


func _ready():
	for i in GameState.levels.size():
		var button = Button.new()
		button.custom_minimum_size = Vector2(28, 16)
		button.text = str(i + 1)
		if i >= GameState.unlocked:
			button.text = "-"
			button.disabled = true
		button.pressed.connect(_on_level_pressed.bind(i))
		button.mouse_entered.connect(_on_button_hover.bind(i))
		grid.add_child(button)


func _on_level_pressed(i):
	if not GameState.go_to_level(i):
		info.text = "LEVEL " + str(i + 1) + " NOT BUILT YET"


func _on_button_hover(i):
	info.text = str(i + 1) + " " + GameState.levels[i]["name"]
