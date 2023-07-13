#roll
extends BallState

func update(_delta):
	
	
	pass

func physics_update(_delta):
	owner.roll(_delta)
	pass
	
func animationEnded(_animName):
	pass
	
func enter():
	owner.SPEED *=4
	pass

func lookedAway():
	owner.startLookAwayTimer()

func lookedAt():
	owner.lookAwayTimer.stop()
	stateMachine.transition_to("EnragedIdle")
	pass # Replace with function body.

func enrageEnded():
	stateMachine.transition_to("Roll")

#Note: Add logic here to see if its a valid spot, otherwise do nothing (enrage?)
func lookAwayTimerEnd():
	owner.startLookAwayTimer()
	pass

func playerTouched():
	get_tree().change_scene_to_file("res://Levels/GameOver.tscn")
	pass

func exit():
	owner.SPEED/=4
	pass
