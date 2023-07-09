extends Node

var winning = 0
var musicArray
var soundArray
signal winProgress


# Called when the node enters the scene tree for the first time.
func _ready():
	musicArray = [
		$GameOver,
		$HorrorZone,
		$BallStyle,
		$Win
	]
	
	soundArray = [
		$Chime,
		$Walk	
	]
	
	pass # Replace with function body.

func playSong(index: int):
	musicArray[index].play(0)

func playSound(index: int):
	soundArray[index].play(0)

func stopSound(index: int):
	soundArray[index].stop()

func stopAll():
	for i in range(musicArray.size()):
		musicArray[i].stop()

func raiseWinning():
	winning+=1
	winProgress.emit()
	if winning>=8:
		get_tree().change_scene_to_file("res://Levels/Win.tscn")
