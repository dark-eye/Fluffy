shader_type canvas_item;
render_mode blend_mix;

uniform sampler2D windTex;
uniform sampler2D gustTex;
uniform float gustFactor = 2.0;
uniform vec4 baseColor : hint_color = vec4(0,0,0,0.1);
uniform vec2 windVector = vec2(1,0);



void fragment() {
	vec2 timedVector = windVector * -0.1 * TIME;
	COLOR =  baseColor * (texture(gustTex,SCREEN_UV *(gustFactor/2.0)+ timedVector * gustFactor)) * texture(windTex,SCREEN_UV + timedVector);
}
