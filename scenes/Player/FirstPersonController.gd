extends KinematicBody

var speed = 7
var acceleration = 10
var gravity = 0.09
var jump = 10

var mouse_sensitivity = 0.05

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3() 

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
	
	if Input.is_action_pressed("forward"):
	
		direction -= transform.basis.z
	
	elif Input.is_action_pressed("backward"):
		
		direction += transform.basis.z
		
	if Input.is_action_pressed("left"):
		
		direction -= transform.basis.x			
		
	elif Input.is_action_pressed("right"):
		
		direction += transform.basis.x
			
		
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta) 
	velocity = move_and_slide_with_snap(velocity,Vector3.UP, Vector3.UP, true)
