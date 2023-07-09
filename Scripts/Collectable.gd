extends Node3D

@export var activeStart: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	if !activeStart:
		hide()
		MusicGlobal.winProgress.connect(revealSelf)
		$Area3D.monitoring = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func revealSelf():
	show()
	$Area3D.monitoring = true
	MusicGlobal.winProgress.disconnect(revealSelf)


func _on_area_3d_body_entered(body):
	#do pre destroy stuff ie update wincon, play sound, spawn particles
	MusicGlobal.raiseWinning()
	queue_free()
	pass # Replace with function body.
