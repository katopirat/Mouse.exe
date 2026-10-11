extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func intro_play():
	$AnimationPlayer.play("intro")

func _input(event: InputEvent) -> void:
	
	intro_play()
