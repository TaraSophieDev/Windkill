extends KinematicBody

var speed = 8
var acceleration = 10
var gravity = 0.5 #0.09 standard
var jump = 10
var playerPos = translation
var sprint_disabled = false

var mouse_sensitivity = 0.06

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3() 


signal playerWalk
signal send_windmill_signal
signal send_playerPos

onready var head = $Head

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity)) 
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity)) 
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

func _physics_process(delta):
	direction = Vector3()
	
	move_and_slide(fall, Vector3.UP)
	
	if not is_on_floor():
		fall.y -= gravity
			
	if is_on_floor():
		velocity.y = 0
		fall.y = 0
	
	#Moving
	############################################################################
	if Input.is_action_pressed("forward") && !sprint_disabled:
		direction -= transform.basis.z
		if is_on_floor():
			emit_signal("playerWalk")
	
	elif Input.is_action_pressed("backward") && !sprint_disabled:
		direction += transform.basis.z
		if is_on_floor():
			emit_signal("playerWalk")
		
	if Input.is_action_pressed("left") && !sprint_disabled:
		direction -= transform.basis.x
		if is_on_floor():
			emit_signal("playerWalk")
		
	elif Input.is_action_pressed("right") && !sprint_disabled:
		direction += transform.basis.x
		if is_on_floor():
			emit_signal("playerWalk")
	
	if Input.is_action_pressed("sprint") && !sprint_disabled:
		speed = 15
	elif Input.is_action_pressed("sprint") && !sprint_disabled:
		speed = 0
	else:
		speed = 7
		
		
		
	
	#Game Settings
	############################################################################
#	if Input.is_action_just_pressed("reset"):
#		get_tree().change_scene("res://Win_Screen.tscn") #resets scene


	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta) 
	velocity = move_and_slide_with_snap(velocity,Vector3.UP, Vector3.UP, true)



func _on_InteractionRayCast_send_count_signal():
	emit_signal("send_windmill_signal")


func _FallDeath_body_entered(body):
	get_tree().change_scene("res://Death_Screen.tscn")


func _slow_player():
	sprint_disabled = true
