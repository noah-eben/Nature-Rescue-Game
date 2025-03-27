shader_type canvas_item;

uniform float speed = 2.0;

void vertex() {
	UV.y += 0.1 * sin(TIME * 6.0);
}
