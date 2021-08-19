shader_type canvas_item;

uniform sampler2D noise_texture;
uniform float value : hint_range(-1.3, 1.3);
uniform vec4 dissolve_color : hint_color;

void fragment(){
	vec4 uv = texture(TEXTURE, UV);
	vec4 noise_uv = texture(noise_texture, UV);
	
	if (noise_uv.b > 1.1*value){
		COLOR.a = 0.0;
	}
	else if(noise_uv.b < 1.1*value && noise_uv.b > 0.9*value){
		COLOR.a = uv.a;
		COLOR.rgb = dissolve_color.rgb;
	}
	else{
		COLOR = uv;
	}
}