class_name BallStateMachine
extends Node

@export var initial_state := NodePath()

@onready var state: BallState = get_node(initial_state)
# Called when the node enters the scene tree for the first time.
func _ready():
	await owner.ready
	
	for child in get_children():
		child.stateMachine = self
	
	
	if !owner.activeStart:
		MusicGlobal.winProgress.connect(startRolling)
	else:
		state.enter()	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state.update(delta)
	pass
	
func startRolling():
	state.enter()
	MusicGlobal.winProgress.disconnect(startRolling)

func _physics_process(delta):
	state.physics_update(delta)
	pass

func transition_to(target_state_name: String):
	
	if not has_node(target_state_name):
		return
	
	state.exit()
	state = get_node(target_state_name)
	state.enter()


func _on_animation_player_animation_finished(anim_name):
	state.animationEnded(anim_name)
	pass # Replace with function body.


func _on_timer_timeout():
	state.lookAwayTimerEnd()
	pass # Replace with function body.


func _on_area_3d_body_entered(body):
	state.playerTouched()
	pass # Replace with function body.


func _on_visible_on_screen_notifier_3d_screen_entered():
	owner.looking = true
	state.lookedAt()
	pass # Replace with function body.


func _on_visible_on_screen_notifier_3d_screen_exited():
	owner.looking = false
	state.lookedAway()
	pass # Replace with function body.


func _on_enrage_timer_timeout():
	state.enrageEnded()
	pass # Replace with function body.
