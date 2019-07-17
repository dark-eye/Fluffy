extends Control

export(NodePath) var levelControllerPath = null
export(NodePath) var playerControllerPath = null

var endGameTimer = Timer.new();
var physicsBorders = StaticBody2D.new();

#================================================
func _ready():
	endGameTimer.connect("timeout", self, "next_level");
	endGameTimer.stop();
	self.add_child( endGameTimer );
	self.reset();
	pass

#-----------------------------------------

func next_level():
	var lvlctrl = get_level_controller();
	if(lvlctrl.levels.size() > lvlctrl.currentLevel+1):
		lvlctrl.currentLevel += 1;
	else:
		lvlctrl.currentLevel = 0;
	
	self.reset();

func reset():
	get_player_controller().getPlayer().mode=RigidBody2D.MODE_STATIC;
	endGameTimer.stop();
	var lvlctrl = get_level_controller();
	get_level_controller().reset();
	var spawnPoint =lvlctrl.getSpawnPoint();
	get_player_controller().setSpawnPoint(spawnPoint);
	get_player_controller().spawn();
	getCamera().startLevelTween(lvlctrl.currentScene.cameraOverviewZoomout);
	self.find_node("Clock",true).reset()
	get_player_controller().getPlayer().mode=RigidBody2D.MODE_CHARACTER;

#-------------- Signals --------------

func player_at_end_gate():
	if(endGameTimer.is_stopped() ):
		endGameTimer.set_wait_time(2)
		endGameTimer.start(); 
		get_player_controller().getPlayer().find_node('AnimationPlayer').play('going_away');
		var lvlctrl = get_level_controller();
		getCamera().endLevelTween(lvlctrl.currentScene.cameraOverviewZoomout);
		self.find_node("Clock",true).pause();

func level_loaded(idx,levelScene):
	
	var camera = getCamera();
	var bounds = get_level_controller().getBoundsNode();
	if(bounds):
		var boundsRect = bounds.get_rect();
		camera.set_limit(MARGIN_LEFT, boundsRect.position.x);
		camera.set_limit(MARGIN_TOP, boundsRect.position.y);
		camera.set_limit(MARGIN_RIGHT, boundsRect.size.x+boundsRect.position.x);
		camera.set_limit(MARGIN_BOTTOM, boundsRect.size.y+boundsRect.position.y);
		
		self.set_borders(boundsRect);


#--------------------------------------
#TODO move to an external utils
func add_segment_to_body(body,ownderId,v1,v2):
	var shape = SegmentShape2D.new();
	shape.set_a(Vector2(v1.x,v1.y));
	shape.set_b(Vector2(v2.x,v2.y));
	
	body.shape_owner_add_shape(ownderId,shape);
	return body;

func set_borders(bounds):
	self.remove_child(physicsBorders);
	physicsBorders = StaticBody2D.new();
	var ownderId=  physicsBorders.create_shape_owner(physicsBorders);
	self.add_segment_to_body(physicsBorders, ownderId, Vector2(bounds.position.x,bounds.position.y), Vector2(bounds.size.x+bounds.position.x,bounds.position.y));
	self.add_segment_to_body(physicsBorders, ownderId, Vector2(bounds.position.x,bounds.position.y), Vector2(bounds.position.x,bounds.size.y+bounds.position.y));
	self.add_segment_to_body(physicsBorders, ownderId, Vector2(bounds.position.x,bounds.size.y+bounds.position.y), Vector2(bounds.size.x+bounds.position.x,bounds.size.y+bounds.position.y));
	self.add_segment_to_body(physicsBorders, ownderId, Vector2(bounds.size.x+bounds.position.x,bounds.position.y), Vector2(bounds.size.x+bounds.position.x,bounds.size.y+bounds.position.y));
	self.add_child(physicsBorders);

#--------------------------------------

func get_level_controller():
	return get_node(levelControllerPath);

func get_player_controller():
	return get_node(playerControllerPath);
	
func getCamera():
	return self.find_node('Camera2D');

