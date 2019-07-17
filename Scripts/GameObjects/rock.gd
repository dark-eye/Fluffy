tool
extends RigidBody2D

export(Texture) var texture setget _setTexture,_getTexture
export(float,0,1) var roughness setget _setRoughness
export(float) var details setget _setDetails
export(float) var size setget _setSize

onready var rockSprite = $SpritePoly;
onready var collisionPoly = $Collision;

func _ready():
	_clearRock();
	_buildRock();


func _buildRock():

	self.rockSprite.set_texture(self.texture)
	var rotValue = 360 / (360/details);
	var rot=0;
	var shapePoly = PoolVector2Array();
	var uvPoly = PoolVector2Array();
	while(rot < 360):
		rot+=rotValue-(randf()*self.roughness*(rotValue/4));
		var newPoint  = Vector2(size*(1-(randf()*self.roughness)),0);
		newPoint = newPoint.rotated(deg2rad(rot));
		shapePoly.append(newPoint);
		var uvPoint = Vector2(0.5,0);
		uvPoint = uvPoint.rotated(deg2rad(rot));
		uvPoint = uvPoint + Vector2(0.5,0.5)
		uvPoly.append(uvPoint*self.rockSprite.texture.get_size());
	
	self.collisionPoly.polygon = shapePoly;
	self.rockSprite.polygon = shapePoly;
	self.rockSprite.uv = uvPoly;
	self.rockSprite.visible = true
	print("rebuilding rock");
	
func _clearRock():
	self.rockSprite.polygon = PoolVector2Array();
	self.rockSprite.uv = PoolVector2Array();
	self.collisionPoly.polygon = PoolVector2Array();

func _rebuildRock():
	if(self.rockSprite && self.collisionPoly):
		_clearRock();
		_buildRock();

func _setTexture(value):
	texture = value
	_rebuildRock();	

func _getTexture():
	return texture;

	
func _setRoughness(value):
	roughness = value;
	_rebuildRock();
	
func _setDetails(value):
	details = value;
	_rebuildRock();

	
func _setSize(value):
	size = value;
	_rebuildRock();




