extends MeshInstance3D

var mdt = MeshDataTool.new()
var noise = FastNoiseLite.new()
var rng = RandomNumberGenerator.new()

var mymesh = ArrayMesh.new()

var terrainSize = 1000
var terrainHeightScale = 20.0
var sub = 499

var shape = HeightMapShape3D.new()

var heightData

@onready var floormat = preload("res://Assets/Materials/floor_standard_material_3d.tres")

@onready var clutter1 = preload("res://Entities/clutter1.tscn")
@onready var clutter2 = preload("res://Entities/clutter2.tscn")
@onready var clutter3 = preload("res://Entities/clutter3.tscn")
@onready var bf = preload("res://Entities/BallFood.tscn")

@onready var colShape = $StaticBody3D/CollisionShape3D
@export var colliderRatio = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	setupNoise()
	#generateTerrainHM()
	#addClutter(5000)
	await get_tree().create_timer(2).timeout
	get_parent().bake_navigation_mesh(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func setupNoise():
	noise.seed = rng.randi()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	noise.fractal_octaves = 8
	noise.fractal_gain = 0.5
	noise.fractal_lacunarity = 2.0


func addClutter(amount):
	var width = sub+1
	for i in range(amount):
		var x = rng.randf_range(0.0, terrainSize)
		var z = rng.randf_range(0.0, terrainSize)
		var clutterChoice = rng.randi_range(0, 2)
		var clut = bf.instantiate()
#		if clutterChoice == 0:
#			clut = clutter1.instantiate()
#		elif clutterChoice == 1:
#			clut = clutter2.instantiate()
#		else:
#			clut = clutter3.instantiate()
		var meshHeightX = int(floor((x/float(terrainSize)) * float(width)))
		var meshHeightY = int(floor((z/float(terrainSize)) * float(width)))
		clut.set_position(Vector3(x-(terrainSize/2.0), heightData[meshHeightY*(width+1) + meshHeightX], z-(terrainSize/2.0)))
		add_child(clut)


func generateTerrainHM():
	var hm = noise.get_image(sub+2, sub+2)
	hm.save_png("hm.png")
	hm.convert(Image.FORMAT_RF)
	material_override.set_shader_parameter("heightmap", ImageTexture.create_from_image(hm))
	material_override.set_shader_parameter("heightRatio", terrainHeightScale)
#	mesh.size = Vector2(terrainSize, terrainSize)
#	mesh.subdivide_width = sub
#	mesh.subdivide_depth = sub
	heightData = hm.get_data().to_float32_array()
	for i in range(heightData.size()):
		heightData[i] *= terrainHeightScale
		
	var plane = PlaneMesh.new()
	var mymesh = ArrayMesh.new()
	plane.size = Vector2(terrainSize, terrainSize)
	plane.subdivide_width = sub
	plane.subdivide_depth = sub
	mymesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, plane.get_mesh_arrays())
	mdt.create_from_surface(mymesh, 0)
	for i in range(mdt.get_vertex_count()):
		var vertex = mdt.get_vertex(i)
	mesh = mymesh
	
	shape.map_width = hm.get_width()
	shape.map_depth = hm.get_height()
	shape.map_data = heightData
	var scaleRatio = terrainSize/float(hm.get_width())
	colShape.scale = Vector3(scaleRatio, 1, scaleRatio)
	colShape.shape = shape
	#mesh = shape.get_debug_mesh()
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
