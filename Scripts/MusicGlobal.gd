extends Node

var winning = 0
var musicArray

signal ballMassUpdated

# Called when the node enters the scene tree for the first time.
func _ready():
	musicArray = [
		$GameOver
	]
	pass # Replace with function body.

func playSong(index: int):
	musicArray[index].play(0)

func stopAll():
	for i in range(musicArray.size()):
		musicArray[i].stop()

func raiseWinning():
	winning+=1
	if winning>=8:
		get_tree().change_scene_to_file("res://Levels/Win.tscn")
