extends Spatial

onready var level_scene = "res://World.tscn"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
func _process(delta):
	if Input.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

func _start_button_pressed():
	get_tree().change_scene(level_scene)
	
func _close_button_pressed():
	get_tree().quit()


func _HPS1_pressed():
	OS.shell_open("https://hauntedps1.itch.io/")


func _Itch_pressed():
	OS.shell_open("https://terradev.itch.io/")


func _Twitter_pressed():
	OS.shell_open("https://twitter.com/TerraDev64")

