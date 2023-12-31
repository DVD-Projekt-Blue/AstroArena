extends CharacterBody3D

const MAX_FORWARD_SPEED = 150.0
const MAX_BACKWARD_SPEED = 50.0
const MAX_SIDEWAYS_SPEED = 50.0
const MAX_UPDOWN_SPEED = 100.0
const ACCELERATION = 0.2
const MOUSE_SENSITIVITY = 0.1
const INPUT_DEADZONE = 0.1
const BOUNCE_BACK_FORCE = 3.0

var circularAreaRadius : float = 100.0
var roll_speed = 1.5
var yaw_speed = 0.5
var pitch_speed = 1.5
var vel = Vector3.ZERO
var speed = Vector3.ZERO
var roll_input = 0.0
var yaw_input = 0.0
var pitch_input = 0.0
var input_response = 6

@onready var barrel_right = $BarrelRight
@onready var barrel_left = $BarrelLeft
@onready var start_shooting = $ShootingStart
@onready var shooting = $Shooting
@onready var end_shooting = $ShootingEnd
@onready var light_left = $LeftLight
@onready var light_right = $RightLight

var bullet = load("res://bullet.tscn")
var instanceRight
var instanceLeft


func _ready():
	pass

func _input(event):
	if event is InputEventMouseMotion:
		pitch_input = -event.relative.x * MOUSE_SENSITIVITY
		yaw_input = -event.relative.y * MOUSE_SENSITIVITY
		if abs(pitch_input) < INPUT_DEADZONE:
			pitch_input = 0.0
		if abs(yaw_input) < INPUT_DEADZONE:
			yaw_input = 0.0

func shoot(): 
	instanceLeft = bullet.instantiate()
	instanceRight = bullet.instantiate()
	instanceLeft.position = barrel_left.global_position
	instanceRight.position = barrel_right.global_position
	instanceLeft.transform.basis = barrel_left.global_transform.basis
	instanceRight.transform.basis = barrel_right.global_transform.basis
	get_parent().add_child(instanceLeft)
	get_parent().add_child(instanceRight)


func get_input(delta):
	var input_vector = Vector3.ZERO

	if Input.is_action_pressed("thrust forward"):
		input_vector.x += 1.0
	if Input.is_action_pressed("thrust backward"):
		input_vector.x -= 1.0
	if Input.is_action_pressed("strafe right"):
		input_vector.z += 1.0
	if Input.is_action_pressed("strafe left"):
		input_vector.z -= 1.0
	if Input.is_action_pressed("strafe up"):
		input_vector.y += 1.0
	if Input.is_action_pressed("strafe down"):
		input_vector.y -= 1.0
	roll_input = lerp(roll_input, Input.get_action_strength("roll left") - Input.get_action_strength("roll right"), input_response * delta)

	input_vector = input_vector.normalized()

	speed.x = lerp(speed.x, input_vector.x * MAX_FORWARD_SPEED, ACCELERATION * delta)
	speed.y = lerp(speed.y, input_vector.y * MAX_UPDOWN_SPEED, ACCELERATION * delta)
	speed.z = lerp(speed.z, input_vector.z * MAX_SIDEWAYS_SPEED, ACCELERATION * delta)

	if Input.is_action_just_pressed("light"):
		light_left.visible = !light_left.visible
		light_right.visible = !light_right.visible
		
	if Input.is_action_pressed("shoot"):
		$TraumaCauser.cause_trauma()
		shoot()

	if Input.is_action_just_pressed("shoot"):
		shooting.play()


	if Input.is_action_just_released("shoot"):
		shooting.stop()
		end_shooting.play()

func _physics_process(delta):
	get_input(delta)
	transform.basis = transform.basis.rotated(transform.basis.x.normalized(), -roll_input * roll_speed * delta)
	vel = transform.basis.x * speed.x + transform.basis.y * speed.y + transform.basis.z * speed.z
	move_and_collide(vel * delta)
	transform.basis = transform.basis.rotated(transform.basis.y.normalized(), pitch_input * yaw_speed * delta)
	transform.basis = transform.basis.rotated(transform.basis.z.normalized(), yaw_input * pitch_speed * delta)
