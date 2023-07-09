extends Control


# Called when the node enters the scene tree for the first time.

@onready var animationPlayer = $AnimationPlayer
@onready var text = $CanvasLayer/RichTextLabel

func _ready():
	MusicGlobal.winProgress.connect(displayNum)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func displayNum():
	text.text = str(MusicGlobal.winning)+"/8"
	animationPlayer.play("ShowNumber")
