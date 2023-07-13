extends CharacterBody3D




# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var speed: float
func _ready():
	velocity = speed*up_direction

func _physics_process(delta):
	move_and_slide()




