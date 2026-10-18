extends Control
@onready var shader_anim: AnimationPlayer = $"../AnimationPlayer"

func _ready():
	visible = false
	$"../AnimationPlayer/ColorRect".visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func pouse():
	print(get_tree().current_scene )
	var tung_tung_sahur = !get_tree().paused
	$VBoxContainer/Button
	if tung_tung_sahur == true:
		
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		visible = tung_tung_sahur
		$"../AnimationPlayer/ColorRect".visible = true
		shader_anim.play("fade_in")
		get_tree().paused = tung_tung_sahur
		await shader_anim.animation_finished
		
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
		shader_anim.play_backwards("fade_in")
		await shader_anim.animation_finished
		get_tree().paused = tung_tung_sahur
		
		$"../AnimationPlayer/ColorRect".visible = false
		visible = tung_tung_sahur
	
	
	#$"/root/Music".get_tree().paused = false
	


func _input(event:InputEvent):


	if event.is_action_pressed("esc") :
		if get_tree().current_scene.name == "Menu":
			$VBoxContainer/Button.visible = false
			$VBoxContainer/Button3.visible = true
		else:
			$VBoxContainer/Button.visible = true
			$VBoxContainer/Button3.visible = false
			
		pouse()
		


func _on_button_2_pressed() -> void:
	pouse()


func _on_button_3_pressed() -> void:
	get_tree().quit()
