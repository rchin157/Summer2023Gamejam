extends Node3D

@onready var player = $Player
@onready var ball = $Ball
var foodsArray

# Called when the node enters the scene tree for the first time.
func _ready():
	ball.target = player
	ball.volumeChanged.connect(checkVolume)
	MusicGlobal.stopAll()
	MusicGlobal.playSong(1)
	foodsArray = get_tree().get_nodes_in_group("BallFood")
	pass # Replace with function body.

func checkVolume(volume):
	for i in range(foodsArray.size()-1,-1,-1):
		if foodsArray[i].checkVolume(volume):
			foodsArray.remove_at(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
