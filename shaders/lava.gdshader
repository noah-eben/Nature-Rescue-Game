shader_type canvas_item;

uniform float scrolling_speed = 0.05;

void vertex() {
	UV.x += TIME * scrolling_speed;
}
