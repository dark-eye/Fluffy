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

#-------------- Signals --------------

func player_at_end_gate():
	if(!endGameTimer.is_active() ):
		endGameTimer.set_wait_time(2)
		endGameTimer.start()
		endGameTimer.set_active( true );

func level_loaded(idx,levelScene):
	self.remove_child(physicsBorders);
	var camera = get_player_controller().getCamera();
	var bounds = get_level_controller().getBoundsNode();
	if(bounds):
		var boundsRect = bounds.get_item_rect();
		camera.set_limit(MARGIN_LEFT, boundsRect.pos.x);
		camera.set_limit(MARGIN_TOP, boundsRect.pos.y);
		camera.set_limit(MARGIN_RIGHT, boundsRect.size.width+boundsRect.pos.x);
		camera.set_limit(MARGIN_BOTTOM, boundsRect.size.height+boundsRect.pos.y);
		var s1 = SegmentShape2D.new();
		s1.set_a(Vector2(boundsRect.pos.x,boundsRect.pos.y));s1.set_b(Vector2(boundsRect.size.width+boundsRect.pos.x,boundsRect.pos.y));
		var s2 = SegmentShape2D.new();
		s2.set_a(Vector2(boundsRect.pos.x,boundsRect.pos.y));s2.set_b(Vector2(boundsRect.pos.x,boundsRect.size.height+boundsRect.pos.y));
		var s3 = SegmentShape2D.new();
		s3.set_a(Vector2(boundsRect.pos.x,boundsRect.size.height+boundsRect.pos.y));s3.set_b(Vector2(boundsRect.size.width+boundsRect.pos.x,boundsRect.size.height+boundsRect.pos.y));
		var s4 = SegmentShape2D.new();
		s4.set_a(Vector2(boundsRect.size.width+boundsRect.pos.x,boundsRect.pos.y));s4.set_b(Vector2(boundsRect.size.width+boundsRect.pos.x,boundsRect.size.height+boundsRect.pos.y));
		
		physicsBorders = StaticBody2D.new();
	
		physicsBorders.add_shape(s1);
		physicsBorders.add_shape(s2);
		physicsBorders.add_shape(s3);
		physicsBorders.add_shape(s4);
		
		self.add_child(physicsBorders);

#--------------------------------------

func get_level_controller():
	return get_node(levelControllerPath);

func get_player_controller():
	return get_node(playerControllerPath);