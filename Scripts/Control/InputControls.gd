extends Container

# class member variables go here, for example:

export(NodePath) var jumpPath = null;
export(NodePath) var leftPath = null;
export(NodePath) var rightPath = null;
export(NodePath) var characterControllerPath = null

var jump = TextureButton;
var left = TextureButton;
var right = TextureButton;
var characterController = Control;

func _ready():
	if(!(jumpPath && leftPath && rightPath && characterControllerPath)):
		printerr("InputControl : not all variables are set.");
		return;
		
	self.jump = self.get_node(jumpPath);
	self.left = self.get_node(leftPath);
	self.right = self.get_node(rightPath);
	self.characterController = self.get_node(characterControllerPath);
	
	if(!(jump && right && left && characterController)):
		printerr("InputControl : not all variables can be found.");
		return;

	self.left.connect("button_down", self.characterController,"rollLeft", [true]);
	self.right.connect("button_down", self.characterController,"rollRight", [true]);
	self.jump.connect("button_down", self.characterController,"floatUp", [true]);
	self.left.connect("button_up", self.characterController,"rollLeft", [false]);
	self.right.connect("button_up", self.characterController,"rollRight", [false]);
	self.jump.connect("button_up", self.characterController,"floatUp", [false]);
