extends OmniLight3D

var timer = 0
var wait = 4
@onready var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if timer >= wait:
		if rng.randi() % 2 == 0:
			if visible:
				hide()
			else:
				show()
		timer = 0
