shader_type spatial;

uniform vec3 water_color : source_color;
uniform float uv_scale: hint_range(0.0, 10, 0.25) = 1.0;
uniform float time_scale: hint_range(0.0, 10.0, 0.25) = 1.0;
uniform sampler2D water_normal_noise;
uniform float bump_strength = 0.5;

uniform float water_color_ratio: hint_range(0.0, 1.0, 0.1) = 1;
uniform float beers_law : hint_range(0.0, 20.0, 0.1) = 3.0;

uniform float normal : hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float roughness: hint_range(0.0, 1.0, 0.1) = 0.5;


uniform float color_ratio : hint_range(0.0, 1.0, 0.1) = 0.5;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable;
uniform sampler2D highlights;

uniform vec2 abberation_r = vec2(0.0, 0.0);
uniform vec2 abberation_g = vec2(0.0, 0.0);
uniform vec2 abberation_b = vec2(0.0, 0.0);
uniform float highlights_time_scale = 1.0;

/* Depth */
uniform sampler2D depth_texture : hint_depth_texture;
uniform float depth_distance : hint_range(0.0, 1.0, 0.1) = 0.5;

vec3 soft_light(vec3 base, vec3 blend) {
	vec3 limit = step(0.5, blend);
	return mix(2.0 * base * blend + base * base * (1.0 - 2.0 * blend),
		sqrt(base) * (2.0 * blend - 1.0) + (2.0 * base) * (1.0 - blend), limit);
}

void fragment() {
	
	vec2 _uv = UV * uv_scale;
	vec2 _suv = SCREEN_UV;
	
	_uv.x += sin( TIME * time_scale + (_uv.x + _uv.y) * 25.0 ) * 0.01;
	_uv.y += cos( TIME * time_scale + (_uv.x - _uv.y) * 25.0 ) * 0.01;
	
	_suv.x += sin( TIME * time_scale + (_suv.x + _suv.y) * 25.0 ) * 0.01;
	_suv.y += cos( TIME * time_scale + (_suv.x - _suv.y) * 25.0 ) * 0.01;
	
	float r = texture(highlights, _uv + abberation_r + TIME * highlights_time_scale).r;
	float g = texture(highlights, _uv + abberation_g + TIME * highlights_time_scale).g;
	float b = texture(highlights, _uv + abberation_b + TIME * highlights_time_scale).b;


	
	vec3 blended = soft_light(texture(screen_texture, _suv).rgb, vec3(r,g,b));
	
	/* Depth */
	vec3 screen = textureLod(screen_texture, SCREEN_UV, 0.0).rgb;
	float depth_r = textureLod(depth_texture, SCREEN_UV, 0.0).r;
	vec4 world = INV_PROJECTION_MATRIX * vec4(SCREEN_UV * 2.0 - 1.0, depth_r, 1.0);
	world.xyz /= world.w;
	float depth_blend = smoothstep(world.z+ depth_distance, world.z, VERTEX.z);
	depth_blend = exp(depth_blend*-beers_law);
	
	/* End of Depth */
	ALBEDO = blended;
	//ALBEDO = mix(screen * depth_blend, water_color, water_color_ratio);
	NORMAL_MAP = texture(water_normal_noise, _uv).rgb;
	NORMAL *= bump_strength;
	ROUGHNESS = roughness;
	
	ALPHA = 0.5;
}