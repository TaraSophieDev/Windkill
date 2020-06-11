extends AudioStreamPlayer

var start
var last_sound
var player
var timer = 0
var delay_time = 0.7

var random_pitch

func _ready():
	pass
	
func _process(delta):
	timer += delta
	


func _on_Player_playerWalk():
	if timer > 0.5:
		play()
		timer = 0
	
