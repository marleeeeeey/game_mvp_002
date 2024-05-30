shader_type canvas_item;

// https://www.youtube.com/watch?v=-4jVIKix-yk

uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
uniform float amount: hint_range(0.0, 5.0);

void fragment() {
	COLOR.rgb = textureLod(screen_texture, SCREEN_UV, amount).rgb;
}
