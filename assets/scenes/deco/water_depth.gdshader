shader_type spatial;

uniform vec3 water_color : source_color;
uniform sampler2D water_noise_1;
uniform sampler2D water_noise_2;

uniform sampler2D depth_texture : hint_depth_texture, repeat_disable, filter_nearest_mipmap;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest_mipmap;
uniform float depth_distance : hint_range(0.0, 10.0, 0.1) = 0.5;
uniform float water_color_ratio : hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float beers_law : hint_range(0.0, 20.0, 0.1) = 3.0;

uniform float normal_scale : hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float roughness_scale : hint_range(0.0, 1.0, 0.1) = 0.2;
uniform float time_scale : hint_range(0.0, 10.0, 0.1) = 5.0;
uniform float uv_scale: hint_range(0.0, 10.0, 0.1) = 1.0;

varying vec4 world_uv;

void vertex() {
	world_uv = MODEL_MATRIX * vec4(VERTEX, 1.0);
}

void fragment() {

	vec2 _uv = world_uv.xz * uv_scale;

	_uv.x += sin( TIME * time_scale + (_uv.x + _uv.y) * 25.0) * 0.01;
	_uv.y += cos( TIME * time_scale + (_uv.x - _uv.y) * 25.0) * 0.01;;


	float depth_r = textureLod(depth_texture, SCREEN_UV, 0.0).r;
	vec4 world = INV_PROJECTION_MATRIX * vec4(SCREEN_UV * 2.0 - 1.0, depth_r, 1.0);
	world.xyz /= world.w;
	float depth_blend = smoothstep(world.z + depth_distance, world.z, VERTEX.z);
	depth_blend = exp(depth_blend * -beers_law);
	depth_blend = clamp(pow(depth_blend, 3.0), 0.0, 1.0);

	vec3 screen = textureLod(screen_texture, SCREEN_UV, 0.0).rgb;

	ALBEDO = mix(screen * depth_blend, water_color, water_color_ratio);
	NORMAL_MAP = mix(texture(water_noise_1, _uv).rgb, texture(water_noise_2, _uv).rgb, (sin(TIME * time_scale) + 1.0) / 2.0);
	NORMAL *= normal_scale;
	ROUGHNESS = roughness_scale;
}