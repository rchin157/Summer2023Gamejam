extends Node3D

var mdt = MeshDataTool.new()
var noise = FastNoiseLite.new()
var rng = RandomNumberGenerator.new()

var mesh = ArrayMesh.new()
var mi3 = MeshInstance3D.new()

var terrainSizeX = 100
var terrainSizeY = 100
var subX = 20
var subY = 20


# Called when the node enters the scene tree for the first time.
func _ready():
	setupNoise()
	generateTerrain()
	mi3.mesh = mesh
	mi3.create_trimesh_collision()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func generateTerrain():
	var plane = PlaneMesh.new()
	plane.size = Vector2(terrainSizeX, terrainSizeY)
	plane.subdivide_width = subX
	plane.subdivide_depth = subY
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, plane.get_mesh_arrays())
	mdt.create_from_surface(mesh, 0)
	var width = subX+2
	var depth = subY+2
	for i in range(width):
		for j in range(depth):
			var vertex = mdt.get_vertex(i*width + j)
			var height = noise.get_noise_2d(i, j)
			vertex += Vector3(0, 20*abs(height), 0)
			mdt.set_vertex(i*width + j, vertex)
	mesh.clear_surfaces()
	mdt.commit_to_surface(mesh)
	add_child(mi3)


func setupNoise():
	noise.seed = rng.randi()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX_SMOOTH
	noise.fractal_octaves = 8
	noise.fractal_gain = 0.5
	noise.fractal_lacunarity = 2.0
