extends KinematicBody

onready var anim_player = $Graphics/Monster/AnimationPlayer

enum STATES {WALK, CHASE, ATTACK}

var cur_state = STATES.WALK

func _ready():
	set_state_walk()
	
func _process(delta):
	match cur_state:
		STATES.WALK:
			process_state_walk(delta)
		STATES.CHASE:
			process_state_chase(delta)
		STATES.ATTACK:
			process_state_attack(delta)

func set_state_walk():
	cur_state = STATES.WALK
	anim_player.play("walk_loop")
	
func set_state_chase():
	cur_state = STATES.CHASE
	anim_player.play("walk_loop")
	
func set_state_attack():
	cur_state = STATES.ATTACK
	anim_player.play("attack")
	
func process_state_walk(delta):
	pass
	
func process_state_chase(delta):
	pass
	
func process_state_attack(delta):
	pass
