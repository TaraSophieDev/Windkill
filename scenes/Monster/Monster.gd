extends KinematicBody

onready var anim_player = $Graphics/Monster/AnimationPlayer
onready var eyes = $Eyes
onready var raycast = $RayCast

enum {
	WALK, 
	CHASE, 
	ATTACK
}

var state = WALK
var target
var direction
var fall = Vector3()
var gravity = 0.5
var velocity = Vector3()
export var speed = 150

var TURN_SPEED = -2

func _ready():
	pass

	
func _body_entered(body):
	if body.is_in_group("player"):
		if raycast.is_colliding():
			var attack = raycast.is_colliding()
			if attack.is_in_group("player"):
				print("hit")
		else:
			state = CHASE
			target = body

func _body_exited(body):
	if body.is_in_group("player"):
		state = WALK


func _process(delta):
	if !is_on_floor():
		fall.y -= gravity
	else:
		velocity.y = 0
		fall.y = 0
	match state:
		WALK:
			anim_player.play("walk_loop")
		CHASE:
			anim_player.play("walk_loop")
			eyes.look_at(target.global_transform.origin, Vector3.UP)
			rotate_y(deg2rad(eyes.rotation.y / TURN_SPEED))
			direction = (target.transform.origin - transform.origin).normalized()
			move_and_slide_with_snap(direction * speed * delta, Vector3.UP)
			
		ATTACK:
			anim_player.play("attack")




