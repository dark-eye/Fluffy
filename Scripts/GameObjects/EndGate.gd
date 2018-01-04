extends Area2D

signal  player_at_end_gate

export var isopen=false setget _set_open,_get_open

var spriteAnim

func _ready():
	self.connect("body_enter",self,'on_enter');
	self.spriteAnim = self.get_node("AnimatedSprite");

func on_enter( body ):
	if(body.is_in_group('Player') && self.isopen):
		self.emit_signal('player_at_end_gate', body );
		self.get_tree().call_group(0,'Control','player_at_end_gate');

func _set_open(value):
	isopen = value
	if(self.spriteAnim):
		if(isopen):
			self.spriteAnim.set_frame(1);
		else:
			self.spriteAnim.set_frame(0);

func _get_open():
	return isopen

