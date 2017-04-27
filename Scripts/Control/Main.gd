extends Control

export(NodePath) var levelControllerPath = null
export(NodePath) var playerControllerPath = null

var endGameTimer = Timer.new();

#================================================
func _ready():
	endGameTimer.connect("timeout", self, "next_level");
	endGameTimer.set_active( false );
	self.add_child( endGameTimer );
	self.reset();
	pass

#-----------------------------------------

func next_level():
	var lvlctrl = get_level_controller();
	if(lvlctrl.levels.size() < lvlctrl.currentLevel+1):
		lvlctrl.currentLevel += 1;
	else:
		lvlctrl.currentLevel = 0;
	
	self.reset();

func reset():
	endGameTimer.set_active( false );
	get_level_controller().reset();
	var spawnPoint = get_level_controller().getSpawnPoint();
	get_player_controller().setSpawnPoint(spawnPoint);
	get_player_controller().spawn();

#-------------- Signals --------------

func player_at_end_gate():
	if(!endGameTimer.is_active() ):
		endGameTimer.set_wait_time(2)
		endGameTimer.start()
		endGameTimer.set_active( true );

func level_loaded(idx,levelScene):
	var camera = get_player_controller().getCamera();
	var bounds = get_level_controller().getBoundsNode();
	if(bounds):
		var boundsRect = bounds.get_item_rect();
		camera.set_limit(MARGIN_LEFT, boundsRect.pos.x);
		camera.set_limit(MARGIN_TOP, boundsRect.pos.y);
		camera.set_limit(MARGIN_RIGHT, boundsRect.size.width+boundsRect.pos.x);
		camera.set_limit(MARGIN_BOTTOM, boundsRect.size.height+boundsRect.pos.y);

#--------------------------------------

func get_level_controller():
	return get_node(levelControllerPath);

func get_player_controller():
	return get_node(playerControllerPath);