
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"
var rotSampling = 10;

func _ready():
	# Initialization here
	self.set_process_input(true)
	
	
func _input(event):
	if(event is InputEventMouseMotion):
		var localEvent = make_input_local( event )
		var pos = self.get_position()
		self.set_rotation( self.get_rotation() - (self.get_rotation()/rotSampling) + (pos.angle_to_point(localEvent.position) / rotSampling) ) 
	pass

