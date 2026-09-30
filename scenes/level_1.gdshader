shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float scanline_strength : hint_range(0.0, 1.0) = 0.12;
uniform float curvature : hint_range(0.0, 0.5) = 0.04;
uniform float vignette_strength : hint_range(0.0, 50.0) = 0.25;
uniform float aberration : hint_range(0.0, 0.5) = 0.0015;
uniform float noise_strength : hint_range(0.0, 10.0) = 0.1;
uniform vec4 tint : source_color = vec4(1.0, 1.0, 1.0, 1.0);

float rand(vec2 co) {
	return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	// lokální souřadnice v rámci obdélníku monitoru (0-1)
	vec2 centered = UV * 2.0 - 1.0;
	float r2 = dot(centered, centered);
	vec2 warp_offset = centered * curvature * r2 * 0.5;

	if (UV.x + warp_offset.x < 0.0 || UV.x + warp_offset.x > 1.0 || UV.y + warp_offset.y < 0.0 || UV.y + warp_offset.y > 1.0) {
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	} else {
		// vzorkuje se ze skutečné obrazovkové pozice, ne z lokálního UV
		vec2 screen_uv = SCREEN_UV + warp_offset;

		float r = texture(SCREEN_TEXTURE, screen_uv + vec2(aberration, 0.0)).r;
		float g = texture(SCREEN_TEXTURE, screen_uv).g;
		float b = texture(SCREEN_TEXTURE, screen_uv - vec2(aberration, 0.0)).b;
		vec3 col = vec3(r, g, b);

		float scanline = sin(UV.y * 800.0 - TIME * 5.0) * 0.5 + 0.5;
		col *= 1.0 - scanline_strength * scanline;

		float vignette = 1.0 - vignette_strength * r2;
		col *= vignette;

		float n = rand(UV + vec2(TIME * 0.001, 0.0));
		col += (n - 0.5) * noise_strength;

		col *= tint.rgb;

		COLOR = vec4(col, 1.0);
	}
}