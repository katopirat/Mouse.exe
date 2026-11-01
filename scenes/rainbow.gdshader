shader_type canvas_item;
uniform float speed = 1.0;
uniform float frequency = 1.0;
uniform float angle = 0.0;
uniform float rainbow_strength = 1.0;


vec3 hsv2rgb(vec3 c){
	vec4 K = vec4(1.0,2.0/3.0,1.0/3.0,3.0);
	vec3 p = abs(fract(c.xxx+K.xyz)*6.0 - K.www);
	return c.z * mix(K.xxx,clamp(p-K.xxx,0.0,1.0),c.y);
}
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex_color = texture(TEXTURE,UV);
	vec2 rotated_uv = vec2(UV.x * cos(angle) - UV.y * sin(angle),UV.x * sin(angle) + UV.y * cos(angle));
	float hue = fract(rotated_uv.x * frequency - TIME * speed);
	vec3 rainbow = hsv2rgb(vec3(hue, 1.0, 1.0));
	COLOR.rgb = mix(tex_color.rgb, rainbow * tex_color.rgb, rainbow_strength);
    COLOR.a = tex_color.a;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
