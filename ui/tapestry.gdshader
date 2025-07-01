shader_type canvas_item;
render_mode blend_add;

void fragment() {
	COLOR.a = 0.08 + 0.03 * sin(0.6 * TIME);
}
