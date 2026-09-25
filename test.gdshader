shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
void vertex() {
	
}

void fragment() {
    vec2 uv = SCREEN_UV * 2.0 - 1.0;
    float dist = dot(uv, uv);

    vec2 offset = uv * dist * 0.05;
    vec2 warped = uv + offset;
    vec2 final_uv = warped * 0.5 + 0.5;

    if (final_uv.x < 0.0 || final_uv.x > 1.0 || final_uv.y < 0.0 || final_uv.y > 1.0) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        COLOR = texture(screen_texture, final_uv);
    }
}
//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
