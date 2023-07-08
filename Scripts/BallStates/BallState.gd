class_name BallState
extends Node


var stateMachine = null

var boi: Ball

# Called when the node enters the scene tree for the first time.
func ready():
	await owner.ready
	boi = owner as Ball
	print("set boi", boi)
	assert(boi != null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(_delta):
	pass

func physics_update(_delta):
	pass
	
func animationEnded(_animName):
	pass
	
func enter():
	pass

func lookAwayTimerEnd():
	pass

func exit():
	pass
