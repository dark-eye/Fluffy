shader_type canvas_item;
render_mode blend_mix;

uniform vec4 albedo : hint_color = vec4(1,1,1,1);
uniform sampler2D displacement;
uniform sampler2D backgroundDisplacement;
uniform float displacementEffect = 0.1;
uniform float amplitude = 0.1;
uniform float speed = 0.2;

void fragment() {
	float speedTimed = TIME*speed;
    float actualAmplitude = amplitude/10.0;
	//do the wave
    float addPos = ((texture(displacement,UV+TIME*speed/50.0).b * displacementEffect - (displacementEffect/2.0)) + (sin(UV.x*60.0+speedTimed) * actualAmplitude)) - actualAmplitude ;
    vec4 waterEffect = texture(TEXTURE,vec2(UV.x,UV.y + addPos));
	//calculate overlapping displacment
	vec4 backgroundDispMix = mix(texture(backgroundDisplacement,UV-speedTimed/60.0) , texture(backgroundDisplacement,UV+speedTimed/60.0),0.5);
	// calculate main deep water displacment
    vec4 displacmentMix = mix(mix(texture(displacement,UV-speedTimed/60.0) , texture(displacement,UV+speedTimed/60.0),0.5) , backgroundDispMix ,0.5) ;
    COLOR = texture(SCREEN_TEXTURE,fract(mix(SCREEN_UV, displacmentMix.xy, displacementEffect * waterEffect.a))) * waterEffect + (albedo * waterEffect.a);
	NORMAL = backgroundDispMix.rgb * waterEffect.a;
}