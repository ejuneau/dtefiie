shader_type spatial;

uniform sampler2D shrimpTexture;

void vertex() {
	VERTEX.y += sin(TIME * 5.0 + VERTEX.x) *0.2;
}

void fragment() {
	ALBEDO = texture(shrimpTexture, UV).rgb;
}