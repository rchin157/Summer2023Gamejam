#roll
extends BallState

func update(_delta):
	if owner.getMad:
		owner.startEnrage()
		if owner.looking:
			stateMachine.transition_to("EnragedIdle")
		else:
			stateMachine.transition_to("EnragedRoll")
	else:
		owner.roll(_delta)
	pass

func physics_update(_delta):
	pass
	
func animationEnded(_animName):
	stateMachine.transition_to("Roll")
	pass

func lookedAway():
	owner.startLookAwayTimer()

func lookedAt():
	owner.lookAwayTimer.stop()
	pass # Replace with function body.

func enter():
	pass

#Note: Add logic here to see if its a valid spot, otherwise do nothing (enrage?)
func lookAwayTimerEnd():
	var looking = owner.target.debugRayCast(owner.radius+20)
	if looking != null:
		stateMachine.transition_to("Emerge")
		owner.set_visible(false)
		owner.global_position = looking
	pass

func playerTouched():
	get_tree().change_scene_to_file("res://Levels/GameOver.tscn")
	pass

func exit():
	pass
