class_name Ball
extends CharacterBody3D

@onready var navAgent = $NavigationAgent3D
@onready var ballMesh = $"ball"
@onready var animator = $AnimationPlayer
@onready var lookAwayTimer = $Timer

var SPEED = 3.0;
var rng = RandomNumberGenerator.new()
var target
var radius = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.

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
	var mesh = collide.get_collider().get_parent().gibMesh()
	mesh.get_parent().remove_child(mesh)
	ballMesh.add_child(mesh)
	print(pos)
	mesh.position = pos-position
	collide.get_collider().queue_free()
	
	radius = radius+0.25
	setRadius(radius)
	
func setRadius(radius):
	scale = Vector3(radius,radius,radius)

#Spooky Behaviour
func _on_visible_on_screen_notifier_3d_screen_entered():
	print("Ball visible")
	lookAwayTimer.stop()
	pass # Replace with function body.


func _on_visible_on_screen_notifier_3d_screen_exited():
	print("ball exited")
	lookAwayTimer.wait_time = rng.randf_range(2,5)
	lookAwayTimer.start()
	pass # Replace with function body.


func _on_animation_player_animation_finished(_anim_name):
	pass # Replace with function body.
