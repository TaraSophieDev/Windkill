extends KinematicBody

onready var anim_player = $Graphics/Monster/AnimationPlayer
onready var eyes = $Eyes
onready var raycast = $RayCast

signal slow_Player
signal activateStabSound


enum {
	WALK, 
	CHASE, 
	ATTACK
}

var stabbed = false
var state = WALK
var target
var direction
var fall = Vector3()
var gravity = 0.5
var velocity = Vector3()
var TURN_SPEED = 5
var attack_bool = true
var timer = 0
var wait_time = 5
export var speed = 1

func playStabSound():
	if !stabbed:
		$Stab.play()
		#stabbed = true

func _num1():
	speed = 400
func _num2():
	speed = 700
func _num3():
	speed = 850
func _num4():
	speed = 1100

func _2minTimer_timeout():
	speed = 2000

func _body_entered(body):
	if body.is_in_group("player"):
		state = CHASE
		target = body

func _body_exited(body):
	if body.is_in_group("player"):
		state = WALK
		
func _process(delta):
	if raycast.is_colliding() && target.is_in_group("player"):
		emit_signal("slow_Player")
		state = ATTACK
		timer -= delta
	
	move_and_slide(fall, Vector3.UP)
	if not is_on_floor():
		fall.y -= gravity
	if is_on_floor():
		velocity.y = 0
		fall.y = 0
		
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
			eyes.look_at(target.global_transform.origin, Vector3.UP)
			rotate_y(deg2rad(eyes.rotation.y * TURN_SPEED))
			anim_player.play("attack")
			#print(timer)
			playStabSound()
			if -0.48 > timer:
				anim_player.stop()
			#if -1 > timer:
				get_tree().change_scene("res://Death_Screen.tscn")



