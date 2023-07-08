extends CharacterBody3D

@onready var navAgent = $NavigationAgent3D
@onready var COR = $"Center Of Rotation"
@onready var hitbox = $CollisionShape3D
@onready var ballMesh = $"Center Of Rotation/ball"
const SPEED = 3.0;
var radius = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func updateTargetLocation(targetLocation):
	navAgent.target_position = targetLocation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_location = global_transform.origin
	var next_location = navAgent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	navAgent.set_velocity(new_velocity)
	COR.rotate_x( -1.0*delta*velocity.z)
	COR.rotate_z( -1.0*delta*velocity.x)
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
	COR.add_child(mesh)
	print(pos)
	mesh.position = pos-position
	collide.get_collider().queue_free()
	
	radius = radius+0.25
	setRadius(radius)
	
func setRadius(radius):
	hitbox.shape.set_radius(radius)
	COR.position = Vector3(0,radius,0)
	ballMesh.scale = Vector3(radius,radius,radius)
