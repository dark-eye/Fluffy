extends CollisionPolygon2D

var snapForce = 0.1
var defaultStructure = null

func _ready():
	set_process(true);
	

func physics_process(delta, rotation):
	var poly = self.polygon;
	for nodeIdx in range(poly.size()):
		poly[nodeIdx] = self.applyGravity(poly[nodeIdx], transform.origin, Vector2(0,9.8));
		poly[nodeIdx] = applyDefForceOnNode(poly[nodeIdx], nodeIdx, transform.origin, rotation);
		
		self.polygon = poly;


func applyDefForceOnNode(polyVec, nodeIdx, center, rotation):
	if( defaultStructure && defaultStructure.polygon ):
		polyVec = polyVec + ( (defaultStructure.polygon[nodeIdx]-center) - (polyVec-center)) * \
				(	snapForce * Vector2(1,1) + (( polyVec - center).rotated(rotation).abs().normalized()*Vector2(1,1)) );
				#+ snapForce * ( polyVec - center).rotated(rotation).abs().normalized()
	
	return polyVec;

func applyGravity(polyVec, center, gravVec):
	polyVec += gravVec;
	return polyVec;

func applyCollisionToNodes(body):
	if( self.polygon ):
		for nodeIdx in range(self.polygon.size()):
			pass
