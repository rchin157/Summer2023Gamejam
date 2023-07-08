extends MeshInstance3D

var mdt = MeshDataTool.new()
var noise = FastNoiseLite.new()
var rng = RandomNumberGenerator.new()

var mymesh = ArrayMesh.new()

var terrainSizeX = 1000
var terrainSizeY = 1000
var terrainHeightScale = 20.0
var subX = 500
var subY = 500

var heights = []

@onready var floormat = preload("res://Assets/Materials/floor_standard_material_3d.tres")

@onready var clutter1 = preload("res://Entities/clutter1.tscn")
@onready var clutter2 = preload("res://Entities/clutter2.tscn")
@onready var clutter3 = preload("res://Entities/clutter3.tscn")
@onready var bf = preload("res://Entities/BallFood.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	setupNoise()
	generateTerrain()
	create_trimesh_collision()
	addClutter(5000)
	get_parent().bake_navigation_mesh(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func generateTerrain():
	var plane = PlaneMesh.new()
	plane.size = Vector2(terrainSizeX, terrainSizeY)
	plane.subdivide_width = subX
	plane.subdivide_depth = subY
	mymesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, plane.get_mesh_arrays())
	mdt.create_from_surface(mymesh, 0)
	var width = subX+2
	var depth = subY+2
	for i in range(width):
		heights.append([])
		for j in range(depth):
			var vertex = mdt.get_vertex(i*width + j)
			var height = terrainHeightScale*abs(noise.get_noise_2d(i, j))
			heights[i].append(height)
			vertex += Vector3(0, height, 0)
			mdt.set_vertex(i*width + j, vertex)
	mymesh.clear_surfaces()
	mdt.set_material(floormat)
	mdt.commit_to_surface(mymesh)
	mesh = mymesh


func setupNoise():
	noise.seed = rng.randi()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	noise.fractal_octaves = 8
	noise.fractal_gain = 0.5
	noise.fractal_lacunarity = 2.0


func addClutter(amount):
	var width = subX+1
	var depth = subY+1
	for i in range(amount):
		var x = rng.randf_range(terrainSizeX/10.0, terrainSizeX-(terrainSizeX/10.0))
		var z = rng.randf_range(terrainSizeX/10.0, terrainSizeX-(terrainSizeX/10.0))
		var clutterChoice = rng.randi_range(0, 2)
		var clut = bf.instantiate()
#		if clutterChoice == 0:
#			clut = clutter1.instantiate()
#		elif clutterChoice == 1:
#			clut = clutter2.instantiate()
#		else:
#			clut = clutter3.instantiate()
		var meshHeightX = int(floor(x/(terrainSizeY/float(width))))
		var meshHeightY = int(floor(z/(terrainSizeY/float(width))))
		clut.set_position(Vector3(x-(terrainSizeX/2.0), heights[meshHeightY][meshHeightX], z-(terrainSizeX/2.0)))
		add_child(clut)

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
