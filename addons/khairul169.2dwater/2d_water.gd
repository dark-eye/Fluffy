tool
extends Sprite

export(ImageTexture) var displacement_map setget _set_dispmap, _get_dispmap;
export(float) var amplitudo = 0.005 setget _set_amplitudo, _get_amplitudo;
export(float) var speed = 1.0 setget _set_speed, _get_speed;
export(Vector2) var uv_size = Vector2(1,1) setget _set_uv_size, _get_uv_size;
export(float) var bubbles_frequency = 0.05;
export(float) var bubbles_randomness = 0.05;

var mat = CanvasItemMaterial.new();
var shader = preload("res://addons/khairul169.2dwater/2d_water.tres");
var bubbles;
var water_area;

func _enter_tree():
	bubbles = self.find_node( 'bubbles' );
	bubbles.set_emitting(false);
	water_area = self.find_node('AffectedArea' );
	mat.set_shader(shader);
	set_material(mat);
	update_water();
	add_bubbles(bubbles);


func update_water():
	mat.set_shader_param("displacement_map", displacement_map);
	mat.set_shader_param("amplitudo", amplitudo);
	mat.set_shader_param("speed", speed);
	mat.set_shader_param("scaling", uv_size);

func add_bubbles(bubbles_instance):
	
	var mysize = self.get_scale();
	var width = self.get_item_rect().size.width / mysize.x;
	var height = self.get_item_rect().size.height / mysize.y / 2;
	var padding = (mysize.x*0.05);
	var i=padding;
	while( i < mysize.x - padding && bubbles_frequency > 0):
		i += mysize.x*((1-bubbles_frequency)+(((bubbles_randomness/2) - randf()*bubbles_randomness))/10);
		if(i < mysize.x - padding):
			var new_bubs = bubbles.duplicate();
			self.add_child(new_bubs);
			new_bubs.set_pos( Vector2(-width/2+i*width,height));
			new_bubs.set_emitting(true);

func _set_dispmap(new):
	displacement_map = new;
	update_water();

func _set_amplitudo(new):
	amplitudo = new;
	update_water();

func _set_speed(new):
	speed = new;
	update_water();

func _set_uv_size(new):
	uv_size = new;
	update_water();

func _get_dispmap():
	return displacement_map;

func _get_amplitudo():
	return amplitudo;

func _get_speed():
	return speed;

func _get_uv_size():
	return uv_size;