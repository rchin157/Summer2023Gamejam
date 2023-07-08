extends CharacterBody3D


const SPEED = 1000
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var inputBools = [0,0,0,0]
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var debugCube := $DebugCube
@onready var frontcast := $Neck/Camera3D/LookRayCast
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30),deg_to_rad(30))
			
func _physics_process(delta):
	#Add the gravity.
	
	var mx = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	var my = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	var horizontalVel = (neck.transform.basis * Vector3(mx, 0, my)).normalized()*SPEED*delta
	velocity.x = horizontalVel.x
	velocity.z = horizontalVel.z
	
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		debugRayCast(200)

	
	move_and_slide()

func debugRayCast(minimumDist):
	var maxAngle = deg_to_rad(camera.fov-20)
	var yAngle = rng.randf_range(-maxAngle,maxAngle)
	var xAngle = rng.randf_range(-maxAngle/2,maxAngle/2)
	var distance
	frontcast.rotate_y(yAngle)
	for i in 20:
		frontcast.rotate_x(xAngle)
		frontcast.force_raycast_update()
		frontcast.rotate_x(-xAngle)
		if frontcast.is_colliding():
			distance = frontcast.global_position.distance_to(frontcast.get_collision_point())
			if distance>minimumDist:
				break
			else:
				xAngle+=0.25
		else:
			xAngle-=0.5
		if i == 20:
			return null
	
	debugCube.position = frontcast.get_collision_point()
	frontcast.set_rotation(Vector3.ZERO)
	return frontcast.get_collision_point()
