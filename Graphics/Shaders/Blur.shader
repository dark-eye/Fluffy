shader_type canvas_item;

uniform float radiusX = 15;
uniform float radiusY = 15;
uniform float blurStrengh = 0.01;
uniform float blurfragment = 0.005;

void fragment() {
	vec4 blurred = texture(SCREEN_TEXTURE,SCREEN_UV);
	for (float x = 0.0; x < radiusX; x++) {
		for (float y = 0.0; y < radiusY; y++) {
			vec2 addUV = blurfragment * (vec2(x,y)-(vec2(radiusX,radiusY)/2.0));
			vec2 addUVReversed = blurfragment * (vec2(y,x)-(vec2(radiusY,radiusX)/2.0));
			blurred = mix(blurred,texture(SCREEN_TEXTURE,clamp(SCREEN_UV+addUV,vec2(0.0,0.0),vec2(1.0,1.0))),blurStrengh);
			blurred = mix(blurred,texture(SCREEN_TEXTURE,clamp(SCREEN_UV+addUVReversed,vec2(0.0,0.0),vec2(1.0,1.0))),blurStrengh);
		}
	}
	COLOR = blurred;
}