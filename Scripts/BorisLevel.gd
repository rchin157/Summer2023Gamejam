extends Node3D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Ball").target = player
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
