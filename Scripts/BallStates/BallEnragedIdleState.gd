#roll
extends BallState

func update(_delta):	
	pass

func physics_update(_delta):
	pass
	
func animationEnded(_animName):
	pass
	
func enter():
	owner.staticPlayer.stop()
	owner.set_velocity(Vector3.ZERO)
	owner.navAgent.set_velocity(Vector3.ZERO)
	pass
func lookedAway():
	owner.startLookAwayTimer()
	stateMachine.transition_to("EnragedRoll")

func lookedAt():
	owner.lookAwayTimer.stop()
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
	owner.staticPlayer.play(0)
	pass
