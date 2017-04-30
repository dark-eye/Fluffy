tool
extends Node2D

signal level_loaded

export(StringArray) var levels = [] 
export(int) var currentLevel = 0 setget _set_currentLevel, _get_currentLevel;
var currentScene = null

func _ready():
	loadLevel( currentLevel );

#=================================================================

func loadLevel(levelIdx):
	if(levels.size() <= levelIdx):
		return;
	
	if(currentScene):
		self.remove_child( currentScene )
		
	currentScene = load(levels[levelIdx]).instance();
	self.add_child( currentScene )
	
	if(get_tree() != null):
		self.emit_signal('level_loaded',levelIdx,currentScene);
		self.get_tree().call_group(0,'Control','level_loaded',levelIdx,currentScene);


func reset():
	if(currentScene):
		loadLevel(currentLevel);

#----------------------------------------------------------

func getSpawnPoint():
	if(!currentScene):
		return false;
	
	var spawnPoint = currentScene.find_node('SpawnPoint');
	if(!spawnPoint):
		return false;
	
	return spawnPoint.get_pos();

func getBoundsNode():
	if(!currentScene):
		return false;
	
	var bounds = currentScene.find_node('Bounds');
	if(!bounds):
		return false;
	
	return bounds;

#---------------------------------------------------------------

func _set_currentLevel(newLevel):
	self.loadLevel(newLevel)
	currentLevel = newLevel

func _get_currentLevel():
	return currentLevel;