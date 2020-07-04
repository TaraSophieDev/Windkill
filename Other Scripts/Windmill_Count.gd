extends Label

var Win_Screen = preload("res://Win_Screen.tscn")

var number = 0
var alreadyExecuted = false
signal num1
signal num2
signal num3
signal num4

func _ready():
	pass

func update_windmill_count():
	if(!alreadyExecuted):
		number += 1
		text = str("Windmills Activated: ", number)
	
func _process(delta):
	
	match number:
		1:
			emit_signal("num1")
		2:
			emit_signal("num2")
		3:
			emit_signal("num3")
		4:
			emit_signal("num4")
		5:
			get_tree().change_scene("res://Win_Screen.tscn")
