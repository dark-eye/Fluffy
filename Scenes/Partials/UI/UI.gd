extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var uiContainer = $Container

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	uiContainer.rect_scale =  self.get_viewport().size / Vector2(1024,600);
	uiContainer.rect_size =  self.get_viewport().size / (uiContainer.rect_scale*30);
	

