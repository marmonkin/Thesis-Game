shader_type spatial;

uniform sampler2D albedo : source_color;

// Distance fade uniforms
uniform float fade_inner_radius : hint_range(0.0, 50.0) = 10.;
uniform float fade_outer_radius : hint_range(0.0, 10.0) = 4.;

varying vec3 world_position;

float bayer4x4(ivec2 pos) {
	int x = pos.x % 4;
	int y = pos.y % 4;

	float bayer_matrix[16] = float[16](
		0.0/16.0,  8.0/16.0,  2.0/16.0, 10.0/16.0,
		12.0/16.0, 4.0/16.0, 14.0/16.0,  6.0/16.0,
		3.0/16.0, 11.0/16.0,  1.0/16.0,  9.0/16.0,
		15.0/16.0, 7.0/16.0, 13.0/16.0,  5.0/16.0
	);

	return bayer_matrix[y * 4 + x];
}

void vertex() {
	// Calculate world position for distance fade
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	vec4 color_base = COLOR;
	vec4 texture_color = texture(albedo, UV);

	ALBEDO = (color_base * texture_color).rgb;

	float final_alpha = texture_color.a * color_base.a;

	// Linear fade between inner and outer radius
	float distance_to_camera = length(world_position - CAMERA_POSITION_WORLD);
	float fade_factor = clamp((distance_to_camera - fade_inner_radius) / (fade_outer_radius - fade_inner_radius), 0.0, 1.0);

	ivec2 screen_pos = ivec2(FRAGCOORD.xy); // Screen coords

	float dither_value = bayer4x4(screen_pos);

	float visibility = 1.0 - fade_factor;

	// Fully disappear at zero visibility
	if (visibility <= dither_value) {
		discard;
	}

	ALPHA = final_alpha;
}