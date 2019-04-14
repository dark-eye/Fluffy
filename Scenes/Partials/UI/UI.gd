extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var uiContainer = $Container

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#warning-ignore:unused_argument
func _process(delta):
	#TODO move this to viewport size_changed signal
	var rescale = self.get_viewport().size / Vector2(1024,600);
	uiContainer.rect_scale =   Vector2(rescale.x,rescale.x) if rescale.x < rescale.y  else  Vector2(rescale.y,rescale.y);
	uiContainer.rect_size =   self.get_viewport().size / (uiContainer.rect_scale);
	#uiContainer.rect_position = (self.get_viewport().size - uiContainer.rect_size)/2
	

