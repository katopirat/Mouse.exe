extends SubViewportContainer

func  _gui_input(event: InputEvent) -> void:
	$SubViewport.push_input(event)
