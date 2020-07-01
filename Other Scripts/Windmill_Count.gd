extends Label

var number = 0
var alreadyExecuted = false
signal num1
signal num2
signal num3
signal num4
signal num5

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
			emit_signal("num5")
