extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	MusicGlobal.stopAll()
	MusicGlobal.playSong(3)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#Starts the game, currently RylanTest
func _on_button_pressed():
	get_tree().change_scene_to_file("res://Levels/BorisLevel.tscn")
	pass # Replace with function body.
