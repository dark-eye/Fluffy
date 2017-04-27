
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var state = Dictionary();

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_process_input(true);
	self.set_process(true);
	
func _process(delta):
	if(state.has('left') && state.left):
		self.set_angular_velocity( max(self.get_angular_velocity() - 2 ,-20));
		#self.apply_impulse( Vector2(0,0), Vector2(-2,0) );

	if(state.has('right') && state.right):
		self.set_angular_velocity( min(self.get_angular_velocity() + 2 ,20));
		#self.apply_impulse( Vector2(0,0), Vector2(2,0) );
	
	if(state.has('floating') && state.floating):
		self.set_gravity_scale( -3.5 );
		#self.apply_impulse( Vector2(0,0), Vector2(0,-20) );
		self.get_node('./Boing').set_scale( Vector2(1.2,1.2));
	else:
		self.set_gravity_scale( 9.8 );
		self.get_node('./Boing').set_scale( Vector2(1,1));
	
func _input(event):
	if(event.type == InputEvent.KEY ):
		var scancode = event.scancode
		if(scancode == 16777233):
			state.right = event.is_pressed();
		
		if(scancode == 16777231):
			state.left = event.is_pressed();

		if(scancode == 32):
			state.floating = event.is_pressed();	

#########################################

func resetTo(x,y):
	self.set_rot(0);
	self.set_pos(Vector2(x,y));

func getCamera():
	return self.find_node( 'Camera2D' );



