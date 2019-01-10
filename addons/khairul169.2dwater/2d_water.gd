tool
extends Sprite

export(ImageTexture) var displacement_map setget _set_dispmap;
export(ImageTexture) var background_displacement setget _set_background_displacement;
export(Color) var water_color setget _set_water_color;
export(float,0,1) var displacement_effect = 0.02 setget _set_dispeffect;
export(float,0,1) var amplitudo = 0.005 setget _set_amplitudo;
export(float) var speed = 1.0 setget _set_speed_scale;
export(Vector2) var uv_size = Vector2(1,1) setget _set_uv_size;
export(float,0,1) var bubbles_frequency = 0.5 setget _set_bubbles_frequency;
export(float,0,1) var bubbles_randomness = 0.05 setget _set_bubbles_randomness;

var mat = ShaderMaterial.new();
var shader = preload("res://addons/khairul169.2dwater/2d_water.tres");
var bubbles;
var water_area;
var bubblesContainer;

func _enter_tree():
	bubbles = self.find_node( 'bubbles' );
	bubbles.set_emitting(false);
	water_area = self.find_node('AffectedArea' );
	bubblesContainer = self.get_node("BubblesContainer");
	mat.set_shader(shader);
	set_material(mat);
	update_water();
	add_bubbles(bubbles);


func update_water():
	mat.set_shader_param("displacement", displacement_map);
	mat.set_shader_param("backgroundDisplacement", background_displacement);
	mat.set_shader_param("albedo", water_color);
	mat.set_shader_param("displacementEffect", displacement_effect);	
	mat.set_shader_param("amplitude", amplitudo);
	mat.set_shader_param("speed", speed);
	mat.set_shader_param("scaling", uv_size);

func add_bubbles(bubbles_instance):
	
	var mysize = self.get_scale();
	var width = self.texture.get_size().x / mysize.x;
	var height = self.texture.get_size().y / mysize.y / 2;
	var padding = (mysize.x*0.05);
	var i=padding;
	var halfStart = -(width/2) ;
	while( i < mysize.x - padding && bubbles_frequency > 0):
		i += mysize.x*((1-bubbles_frequency)+(((bubbles_randomness/2) - randf()*bubbles_randomness))/10);
		if(i < mysize.x - padding):
			var new_bubs = bubbles.duplicate();
			bubblesContainer.add_child(new_bubs);
			new_bubs.set_position( Vector2(halfStart+i*width,height));
			new_bubs.set_emitting(true);

func refresh_bubbles():
	if(!bubblesContainer):
		return;
	for i in bubblesContainer.get_children():
		bubblesContainer.remove_child(i);
	self.add_bubbles(self.bubbles);

func _set_water_color(new):
	water_color = new
	update_water();

func _set_background_displacement(new):
	background_displacement = new
	update_water();
	
func _set_dispmap(new):
	displacement_map = new;
	update_water();

func _set_amplitudo(new):
	amplitudo = new;
	update_water();

func _set_speed_scale(new):
	speed = new;
	update_water();

func _set_uv_size(new):
	uv_size = new;
	update_water();
	
func _set_dispeffect(new):
	displacement_effect = new;
	update_water();

func _get_dispmap():
	return displacement_map;

func _get_amplitudo():
	return amplitudo;

func _get_speed_scale():
	return speed;

func _get_uv_size():
	return uv_size;

func _get_dispeffect(new):
	return displacement_effect;
	
func _set_bubbles_frequency(new):
	bubbles_frequency = new;
	self.refresh_bubbles();

func _get_bubbles_frequency():
	return bubbles_frequency;
	
func _set_bubbles_randomness(new):
	bubbles_randomness = new
	self.refresh_bubbles();
	
func _get_bubbles_randomness():
	return bubbles_randomness;
