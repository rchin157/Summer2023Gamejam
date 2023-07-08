extends CharacterBody3D

@onready var navAgent = $NavigationAgent3D

const SPEED = 3.0;
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
	
	velocity = new_velocity
	move_and_slide()
	rotate_z( -1.0*delta*velocity.x)
	rotate_x( 1.0*delta*velocity.z)
	pass
