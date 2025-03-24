shader_type canvas_item;

uniform float speed = 2.0;

void vertex() {
	UV.x += 0.1 * sin(TIME * 10.0);
}
