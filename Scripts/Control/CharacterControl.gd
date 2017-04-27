extends Control

export(NodePath) var chatacterPath;

var spawnPoint

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func spawn():
	if(null != spawnPoint):
		self.getPlayer().resetTo(spawnPoint.x,spawnPoint.y);
	else:
		self.getPlayer().resetTo(0,0);
	
func setSpawnPoint(newSpawnPoint):
	spawnPoint = newSpawnPoint

func getPlayer():
	return get_node(chatacterPath);

func getCamera():
	return getPlayer().find_node('Camera2D');

