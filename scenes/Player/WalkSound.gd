extends AudioStreamPlayer

var timer = 0
var delay_time = 0.5
	
func _process(delta):
	timer += delta
	


func _on_Player_playerWalk():
	if timer > delay_time:
		play()
		timer = 0
	
