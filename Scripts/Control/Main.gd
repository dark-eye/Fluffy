extends Control

export(NodePath) var levelControllerPath = null
export(NodePath) var playerControllerPath = null

var endGameTimer = Timer.new();
var physicsBorders = StaticBody2D.new();

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
	if(lvlctrl.levels.size() > lvlctrl.currentLevel+1):
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
	get_player_controller().getCamera().find_node('CameraAnimation').play('start_level');

#-------------- Signals --------------

func player_at_end_gate():
	if(!endGameTimer.is_active() ):
		endGameTimer.set_wait_time(2)
		endGameTimer.start()
		endGameTimer.set_active( true );
		get_player_controller().getPlayer().find_node('AnimationPlayer').play('going_away');
		get_player_controller().getCamera().find_node('CameraAnimation').play('end_level');

func level_loaded(idx,levelScene):
	
	var camera = get_player_controller().getCamera();
	var bounds = get_level_controller().getBoundsNode();
	if(bounds):
		var boundsRect = bounds.get_item_rect();
		camera.set_limit(MARGIN_LEFT, boundsRect.pos.x);
		camera.set_limit(MARGIN_TOP, boundsRect.pos.y);
		camera.set_limit(MARGIN_RIGHT, boundsRect.size.width+boundsRect.pos.x);
		camera.set_limit(MARGIN_BOTTOM, boundsRect.size.height+boundsRect.pos.y);
		
		self.set_borders(boundsRect);


#--------------------------------------
#TODO move to an external utils
func add_segment_to_body(body,v1,v2):
	var shape = SegmentShape2D.new();
	shape.set_a(Vector2(v1.x,v1.y));
	shape.set_b(Vector2(v2.x,v2.y));
	body.add_shape(shape);
	return body;

func set_borders(bounds):
	self.remove_child(physicsBorders);
	physicsBorders = StaticBody2D.new();
	self.add_segment_to_body(physicsBorders, Vector2(bounds.pos.x,bounds.pos.y), Vector2(bounds.size.width+bounds.pos.x,bounds.pos.y));
	self.add_segment_to_body(physicsBorders, Vector2(bounds.pos.x,bounds.pos.y), Vector2(bounds.pos.x,bounds.size.height+bounds.pos.y));
	self.add_segment_to_body(physicsBorders, Vector2(bounds.pos.x,bounds.size.height+bounds.pos.y), Vector2(bounds.size.width+bounds.pos.x,bounds.size.height+bounds.pos.y));
	self.add_segment_to_body(physicsBorders, Vector2(bounds.size.width+bounds.pos.x,bounds.pos.y), Vector2(bounds.size.width+bounds.pos.x,bounds.size.height+bounds.pos.y));
	self.add_child(physicsBorders);

#--------------------------------------

func get_level_controller():
	return get_node(levelControllerPath);

func get_player_controller():
	return get_node(playerControllerPath);