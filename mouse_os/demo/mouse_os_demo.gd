extends Control
# Ukázka MOUSE OS. Hodiny běží, křížek zavře okno, OPEN GATE ukáže toast.

var _t := 0.0

func _process(delta: float) -> void:
	_t += delta
	var s := int(_t)
	$Taskbar/Row/Clock/Time.text = "%02d:%02d" % [s / 60, s % 60]

func _on_close_pressed() -> void:
	$Window.hide()

func _on_open_pressed() -> void:
	$Toast/Msg.text = "GATE OPEN"
	$Toast.show()
