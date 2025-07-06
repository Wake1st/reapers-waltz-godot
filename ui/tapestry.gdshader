shader_type canvas_item;
render_mode blend_add;

uniform float transparency = 1.0;

void fragment() {
	COLOR.a = 0.09 + 0.03 * sin(0.6 * TIME);
}
