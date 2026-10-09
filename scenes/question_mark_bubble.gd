extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $"../Monitor_1/Computer/Cursor".speed == 0:
		$"../Monitor_1/Os/PanelContainer/HBoxContainer2/DeviceLabel".visible = true
		visible = true
	else : 
		$"../Monitor_1/Os/PanelContainer/HBoxContainer2/DeviceLabel".visible = false
		visible = false
