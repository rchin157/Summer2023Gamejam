extends StaticBody3D

@export var mass: int
@export var size: int
@onready var mesh = $Mesh


# Called when the node enters the scene tree for the first time.
func _ready():
	checkVolume(1)
	pass # Replace with function body.

func checkVolume(volume):
	if volume >= size:
		print("Disabling "+str(size))
		$NavigationObstacle3D.avoidance_enabled = false
		return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func gibMesh():
	return mesh
