extends Label

var number = 0
var alreadyExecuted = false

func _ready():
	pass

func update_windmill_count():
	if(!alreadyExecuted):
		number += 1
		text = str("Windmills Activated: ", number)
	
