extends CanvasLayer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func _Retry_pressed():
	get_tree().change_scene("res://World.tscn")

func _Menu_pressed():
	get_tree().change_scene("res://Title_Screen.tscn")

func _Close_pressed():
	get_tree().quit()
