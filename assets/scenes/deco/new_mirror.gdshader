shader_type spatial;

uniform sampler2D viewport_texture;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// Parameters will be updated in real-time
uniform vec2 TR = vec2(0,0);
uniform vec2 TL = vec2(0,0);
uniform vec2 BR = vec2(0,0);
uniform vec2 BL = vec2(0,0);

uniform vec2 tiling = vec2(1.0);
uniform vec2 offset = vec2(0.0);
varying vec4 NODE_POSITION_CLIP;


void vertex() {


	 NODE_POSITION_CLIP = (PROJECTION_MATRIX * vec4(NODE_POSITION_VIEW, 1.0));

	// TODO crop & scale viewport_texture t retrieved points
	UV.x = (1.0 - UV.x);
}

void fragment() {
	//vec2 local_uv = (SCREEN_UV) * NODE_POSITION_CLIP.w - NODE_POSITION_CLIP.xy;
	vec2 local_uv = SCREEN_UV;

	// Adjust for aspect ratio and FOV
	local_uv.x *= VIEWPORT_SIZE.x / VIEWPORT_SIZE.y;
	local_uv *= -1.0 / PROJECTION_MATRIX[1][1];


	//ALBEDO = texture(viewport_texture, local_uv * tiling + 0.5 + offset).rgb;
	ALBEDO = texture(viewport_texture, UV).rgb;


}
