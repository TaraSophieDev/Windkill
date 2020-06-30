extends KinematicBody

onready var anim_player = $Graphics/Monster/AnimationPlayer
onready var eyes = $Eyes
onready var raycast = $RayCast


enum {
	WALK, 
	CHASE, 
	ATTACK
}

var death_scene = "res://Death"

var state = WALK
var target
var direction
var fall = Vector3()
var gravity = 0.5
var velocity = Vector3()
var TURN_SPEED = 2
var attack_bool = true
var timer = 0
var wait_time = 5
export var speed = 150

func _num2():
	speed = 300
func _num3():
	speed = 400
func _num4():
	speed = 500



func _body_entered(body):
	if body.is_in_group("player"):
		state = CHASE
		target = body

func _body_exited(body):
	if body.is_in_group("player"):
		state = WALK
		
func attack(delta):
	if raycast.is_colliding() && target.is_in_group("player"):
		state = ATTACK
		timer -= delta

func _process(delta):
	print(speed)
	
	move_and_slide(fall, Vector3.UP)
	if not is_on_floor():
		fall.y -= gravity
	if is_on_floor():
		velocity.y = 0
		fall.y = 0
		
	attack(delta)
		
	match state:
		WALK:
			anim_player.stop()
			#print("idle")
		CHASE:
			anim_player.play("walk_loop")
			eyes.look_at(target.global_transform.origin, Vector3.UP)
			rotate_y(deg2rad(eyes.rotation.y * TURN_SPEED))
			direction = (target.transform.origin - transform.origin).normalized()
			move_and_slide_with_snap(direction * speed * delta, Vector3.UP)
			#print("chase")
			
		ATTACK:
			anim_player.play("attack")
			print(timer)
			if -0.48 > timer:
				anim_player.stop()
			#if -1 > timer:
			#	get_tree().change_scene(death_scene)
