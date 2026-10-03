extends AnimatedSprite2D

@onready var sound_player: AudioStreamPlayer = $AudioStreamPlayerFall

func _ready() -> void:
	# Propojení signálu změny snímku
	frame_changed.connect(_on_frame_changed)

func _on_frame_changed() -> void:
	if animation == "fall" and frame == 9:
		sound_player.play()
