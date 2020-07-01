extends Spatial

onready var level_scene = "res://World.tscn"

func _start_button_pressed():
	get_tree().change_scene(level_scene)
	
func _close_button_pressed():
	get_tree().quit()
