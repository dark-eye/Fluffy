extends Control

export(NodePath) var chatacterPath;

var spawnPoint

func _ready():
	self.set_process_input(true);

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

func _input(event):
	var state = self.getPlayer().get_state();
	if(event.type == InputEvent.KEY ):
		var scancode = event.scancode
		if(scancode == 16777233):
			state.right = event.is_pressed();
		if(scancode == 16777231):
			state.left = event.is_pressed();
		if(scancode == 32):
			state.floating = event.is_pressed();
			
		self.getPlayer().set_state(state);

