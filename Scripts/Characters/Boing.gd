
extends RigidBody2D

export(NodePath) var spriteContainerPath = './Boing'; 

var state = Dictionary() setget get_state,set_state; 
var acceleration = 2;
var maxSpeed=20;
var heavyScale = 9.8;
var floatScale = -3.5;

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_process_input(true);
	self.set_process(true);
	
func _process(delta):
	if(state.has('left') && state.left):
		self.set_angular_velocity( max(self.get_angular_velocity() - acceleration ,-maxSpeed));
		#self.apply_impulse( Vector2(0,0), Vector2(-2,0) );

	if(state.has('right') && state.right):
		self.set_angular_velocity( min(self.get_angular_velocity() + acceleration ,maxSpeed));
		#self.apply_impulse( Vector2(0,0), Vector2(2,0) );
	
	if(state.has('floating') && state.floating):
		self.set_gravity_scale( floatScale );
		#self.apply_impulse( Vector2(0,0), Vector2(0,-20) );
		self.get_node(spriteContainerPath).set_scale( Vector2(1.2,1.2));
	else:
		self.set_gravity_scale( heavyScale );
		self.get_node(spriteContainerPath).set_scale( Vector2(1,1));
	

#########################################

func resetTo(x,y):
	self.set_rot(0);
	self.set_pos(Vector2(x,y));

func getCamera():
	return self.find_node( 'Camera2D' );

#----------------------------------------

func get_state():
	return state;

func set_state(newState):
	state = newState;


