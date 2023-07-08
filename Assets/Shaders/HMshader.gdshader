shader_type spatial;

uniform sampler2D abd;
uniform sampler2D heightmap;
uniform float heightRatio;

void fragment() {
	// Place fragment code here.
	ALBEDO = texture(abd, UV).rgb;
}

void vertex() {
	VERTEX.y += texture(heightmap, UV).r * heightRatio;
	//VERTEX.y += cos(VERTEX.x / 10.0) * sin(VERTEX.z / 10.0);
}