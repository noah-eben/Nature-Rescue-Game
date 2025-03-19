shader_type canvas_item;

uniform float scrolling_speed = 0.000001;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 moving_uv = vec2(UV.x-(TIME*scrolling_speed), UV.y);
	vec4 in_tex = texture(TEXTURE, moving_uv);
	//COLOR = in_tex;
}
