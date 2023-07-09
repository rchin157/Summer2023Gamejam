extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	#do pre destroy stuff ie update wincon, play sound, spawn particles
	print("collectable collected")
	MusicGlobal.raiseWinning()
	get_parent().queue_free()
