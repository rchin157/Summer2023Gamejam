#roll
extends BallState

func update(_delta):
	owner.roll(_delta)
	pass

func physics_update(_delta):
	pass
	
func animationEnded(_animName):
	stateMachine.transition_to("Roll")
	pass
	
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

func exit():
	pass
