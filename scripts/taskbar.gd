extends PanelContainer

var timer_start = 0 
@onready var player = $"../../.."
var p_position
@onready var label = %Time
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p_position = player.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer_start == 0:
		if player.position != p_position:
			timer_start = Time.get_ticks_msec()
		else:
			label.text = Time.get_time_string_from_system().substr(0,5)
	
	else:
		var tot_sec = int((Time.get_ticks_msec() - timer_start) / 1000)
		
		var minutes = tot_sec / 60
		var seconds = tot_sec % 60
		label.text = "%02d:%02d" % [minutes, seconds]
		
