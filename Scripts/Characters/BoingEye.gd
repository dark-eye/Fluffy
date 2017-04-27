
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"
var rotSampling = 10;

func _ready():
	# Initialization here
	self.set_process_input(true)
	
	
func _input(event):
	if(event.type == InputEvent.MOUSE_MOTION):
		var localEvent = make_input_local( event )
		var pos = self.get_pos()
		self.set_rot( self.get_rot() - (self.get_rot()/rotSampling) + (pos.angle_to_point(localEvent.pos) / rotSampling) ) 
	pass
