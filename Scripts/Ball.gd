class_name Ball
extends CharacterBody3D

@onready var navAgent = $NavigationAgent3D
@onready var ballMesh = $"ball"
@onready var animator = $AnimationPlayer
@onready var lookAwayTimer = $Timer
@export var activeStart: bool
@onready var enrageTimer = $EnrageTimer
@onready var staticPlayer = $AudioStreamPlayer3D

var getMad = false
var looking = false;
var SPEED = 3.0;
var rng = RandomNumberGenerator.new()
var target

signal volumeChanged(_volume)

var volume = 1

var radius = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	MusicGlobal.winProgress.connect(_winProgress)
	if !activeStart:
		hide()
	pass # Replace with function body.

func startEnrage():
	MusicGlobal.playSound(0)
	getMad = false
	enrageTimer.start()

func updateTargetLocation(targetLocation):
	navAgent.target_position = targetLocation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func roll(delta):
	updateTargetLocation(target.global_position)
	var current_location = global_transform.origin
	var next_location = navAgent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	navAgent.set_velocity(new_velocity)
	
	var rotateDir = navAgent.velocity.cross(Vector3.DOWN).normalized()
	
	ballMesh.rotate(rotateDir,delta*SPEED)
	pass


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity,0.25)
	if move_and_slide():
		checkCollision()
	pass # Replace with function body.

func checkCollision():
	var collide = get_last_slide_collision()
	var collider = collide.get_collider(0)
	if collider.is_in_group("BallFood"):
		devour(collide)

	pass

func devour(collide):
	var pos = collide.get_position()
	var mesh = collide.get_collider().gibMesh()
	if collide.get_collider().size <= volume:
		var meshPosition = mesh.global_position
		mesh.get_parent().remove_child(mesh)
		ballMesh.add_child(mesh)
		mesh.global_position = meshPosition
		mesh.global_rotation = Vector3.ZERO
		collide.get_collider().queue_free()
		addVolume(collide.get_collider().mass)
	
func addVolume(mass):
	volume+=mass
	volumeChanged.emit(volume)
	radius = sqrt(volume)
	setRadius(radius)

func setRadius(radius):
	scale = Vector3(radius,radius,radius)
	var meshBabies = ballMesh.get_children()
	var inverseScale = Vector3(1/radius,1/radius,1/radius)
	for i in range (1,meshBabies.size(),1):
		meshBabies[i].scale = inverseScale



#Game Gets harder here
func _winProgress():
	if !activeStart:
		show()
		activeStart = true
	else:
		getMad = true;
		SPEED+=0.25

func startLookAwayTimer():
	lookAwayTimer.wait_time = rng.randf_range(2,5)
	lookAwayTimer.start()


func _on_animation_player_animation_finished(_anim_name):
	pass # Replace with function body.
