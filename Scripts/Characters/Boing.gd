
extends RigidBody2D

export(NodePath) var spriteContainerPath = './Boing'; 
export(NodePath) var soundPlayer = './SamplePlayer2D'; 

var state = Dictionary() setget set_state,get_state; 
var acceleration = 2.5;
var maxSpeed=20;
var heavyScale = 9.8;
var floatScale = -3.5;
var lastContact = null;
var lastContactCountAvg = 0.0;

func _ready():
	self.set_process(true);
	self.set_physics_process(true);
	self.set_contact_monitor(true);
	self.connect("body_entered",self,'on_contact');
	self.connect("body_exited",self,'on_body_exit');
	
	
func _process(delta):
	if(state.has('rollForce') && state.rollForce):
			self.set_angular_velocity( max(min(self.get_angular_velocity() + state.rollForce * acceleration ,maxSpeed),-maxSpeed));

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
	

func _physics_process(delta):
	lastContactCountAvg = lastContactCountAvg + (float(self.get_colliding_bodies().size())/2) - (lastContactCountAvg / 35)
	if( int(lastContactCountAvg) == 0 && lastContact != null ):
		lastContact = null;

func on_contact(body):
	if(body != lastContact && body): 
		self.get_node(soundPlayer).play();
		lastContact = body;
		
#TODO should this be reomved? hit volume base on current speed
func _integrate_forces(state):
	if(lastContact && self.get_node(soundPlayer).playing):
		self.get_node(soundPlayer).volume_db = state.get_linear_velocity().length()/100;

func on_body_exit(body):
	pass


#########################################

func resetTo(x,y):
	self.set_rotation(0);
	self.set_position(Vector2(x,y));

func getCamera():
	return self.find_node( 'Camera2D' );

#----------------------------------------

func get_state():
	return state;

func set_state(newState):
	state = newState;



