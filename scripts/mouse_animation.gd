extends AnimatedSprite2D

@onready var sound_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	# Propojení signálu změny snímku
	frame_changed.connect(_on_frame_changed)

func _on_frame_changed() -> void:
	# Zkontrolujte aktuální animaci a číslo snímku (indexy začínají od 0)
	if animation == "fall" and frame == 3:
		sound_player.play()
