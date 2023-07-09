#emerge
extends BallState

func update(_delta):
	pass

func physics_update(_delta):
	pass
	
func animationEnded(_animName):
	stateMachine.transition_to("Roll")
	pass
	
func enter():
	owner.navAgent.set_velocity(Vector3.ZERO)
	owner.set_rotation(Vector3.ZERO)
	owner.ballMesh.set_rotation(Vector3.ZERO)
	print(owner.ballMesh.rotation)
	owner.animator.play("Emerge")
	pass

func lookedAway():
	owner.startLookAwayTimer()

func lookedAt():
	owner.lookAwayTimer.stop()
	pass # Replace with function body.

func lookAwayTimerEnd():
	pass

func exit():
	pass

