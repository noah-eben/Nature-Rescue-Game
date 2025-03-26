shader_type canvas_item;

void vertex() {
	UV.x += TIME * 0.6;
	//UV.y += sin(TIME) * scrolling_speed;
	//VERTEX += vec2(cos(TIME)*1.0, sin(TIME)*1.0);
}
