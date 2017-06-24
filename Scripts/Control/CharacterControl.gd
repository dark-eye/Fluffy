extends Control

export(NodePath) var chatacterPath;

var spawnPoint

func _ready():
	self.set_process_input(true);

func _input(event):
	if(event.type == InputEvent.KEY ):
		var scancode = event.scancode
		if(scancode == 16777233):
			self.rollRight(event.is_pressed());
		if(scancode == 16777231):
			self.rollLeft(event.is_pressed());
		if(scancode == 32):
			self.floatUp(event.is_pressed());

func spawn():
	if(null != spawnPoint):
		self.getPlayer().resetTo(spawnPoint.x,spawnPoint.y);
	else:
		self.getPlayer().resetTo(0,0);
		
	self.getPlayer().find_node('AnimationPlayer').play('coming_back');
	
func setSpawnPoint(newSpawnPoint):
	spawnPoint = newSpawnPoint

func getPlayer():
	return get_node(chatacterPath);

func rollRight(value):
	var state = self.getPlayer().get_state();
	state.right = value;
	self.getPlayer().set_state(state);

func rollLeft(value):
	var state = self.getPlayer().get_state();
	state.left = value;
	self.getPlayer().set_state(state);

func floatUp(value):
	var state = self.getPlayer().get_state();
	state.floating = value;
	self.getPlayer().set_state(state);