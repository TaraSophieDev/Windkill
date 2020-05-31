extends Control

var notPaused = true

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if notPaused:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			get_tree().paused = true
			notPaused = false
			visible = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().paused = false
			notPaused = true
			visible = false
	



func _on_Close_Game_pressed(): #Closes game with button press
	get_tree().quit()


