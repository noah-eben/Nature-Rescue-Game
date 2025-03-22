shader_type canvas_item;

uniform float scrolling_speed = 0.5;

void vertex() {
	UV.x -= TIME * scrolling_speed;
	//UV.y += sin(TIME) * scrolling_speed;
	//VERTEX += vec2(cos(TIME)*1.0, sin(TIME)*1.0);
}
