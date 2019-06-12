extends ParallaxBackground

export(Array,NodePath) var rollingLayers = [];
export(float) var rollingSpeed = 1.0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	for rollingLayer in self.rollingLayers:
		get_node(rollingLayer).motion_offset.x += rollingSpeed * get_node(rollingLayer).motion_scale.x;

