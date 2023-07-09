extends Node3D

@onready var player = $Player
@onready var ball = $Ball

# Called when the node enters the scene tree for the first time.
func _ready():
	ball.target = player
	ball.volumeChanged.connect(checkVolume)
	MusicGlobal.stopAll()
	MusicGlobal.playSong(1)
	pass # Replace with function body.

func checkVolume(volume):
	var foods = get_tree().get_nodes_in_group("BallFood")
	for food in foods:
		food.checkVolume(volume)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
