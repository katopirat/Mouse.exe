extends Control

@onready var grid = $Window/VBoxContainer/GridContainer
@onready var info = $Window/VBoxContainer/HBoxContainer/Info
@onready var best_time = $Window/VBoxContainer/HBoxContainer/BestTime
@onready var time_label = %Time
@onready var player = $"../../../Player"

var timer_start = 0
var p_position: Vector2

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
		if GameState.done.has(i):
			button.theme_type_variation = "ButtonGreen"
		grid.add_child(button)
	
	p_position = player.position

func _process(delta: float) -> void:
	if timer_start == 0:
		if player.position != p_position:
			timer_start = Time.get_ticks_msec()
		else:
			time_label.text = Time.get_time_string_from_system().substr(0,5)
	
	else:
		var tot_sec = int((Time.get_ticks_msec() - timer_start) / 1000)
		
		var minutes = tot_sec / 60
		var seconds = tot_sec % 60
		time_label.text = "%02d:%02d" % [minutes, seconds]


func _on_level_pressed(i):
	if not GameState.go_to_level(i):
		info.text = "LEVEL " + str(i + 1) + " NOT BUILT YET"
	else:
		Global.music_style = "chill"
func _on_button_hover(i):
	info.text = str(i + 1) + " " + GameState.levels[i]["name"]
	best_time.text = "BEST: " + str(GameState.best_times[i])
