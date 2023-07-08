extends NavigationObstacle3D

@export var mass: int
@export var size: int
@onready var mesh = $StaticBody3D/Mesh


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func gibMesh():
	return mesh
