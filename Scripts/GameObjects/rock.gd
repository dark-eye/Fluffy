extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(Texture) var texture setget _setTexture,_getTexture
export(float) var roughness


var rockSprite
var collisionPoly

func _ready():
	self.rockSprite = self.get_node("Sprite");
	self.collisionPoly = self.get_node("Collision");


func _buildRock():
	pass

func _setTexture(value):
	pass

func _getTexture():
	return texture;

