tool
extends RigidBody2D

export(float,0,1) var snapForce = 0.1

var collision = null


# Called when the node enters the scene tree for the first time.
func _ready():
	self.updateCollision();
	self.connect("item_rect_changed",self,"updateCollision");
	set_process(true);
	
func _integrate_forces(state):
	if self.collision :
		self.collision.physics_process(state.step,self.transform.get_rotation());
		self.updateVisual();

func updateCollision():
	self.collision = self.find_node("Collision");
	if !self.collision :
		var placeholderPoly = $Placeholders/DefaultStructure.duplicate();
		placeholderPoly.defaultStructure = $Placeholders/DefaultStructure;
		placeholderPoly.name = "Collision";
		placeholderPoly.set_position( Vector2(0,0) );
		placeholderPoly.snapForce = self.snapForce;
		placeholderPoly.owner = self.owner;
		self.add_child(placeholderPoly);
		collision = placeholderPoly
	else:
		self.collision.snapForce = self.snapForce;
		
	self.updateVisual();
	update()

func updateVisual():
	if self.collision :
		$VisualPoly.polygon = self.collision.polygon

func body_shape_entered(body_id: int, body: Node, body_shape: int, local_shape: int):
	$Collision.applyCollisionToNodes(body)
