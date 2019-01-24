extends Area2D

signal  player_at_end_gate

export var isopen=false setget _set_open,_get_open

var spriteAnim

func _ready():
	self.connect("body_entered",self,'on_enter');
	self.spriteAnim = self.get_node("AnimatedSprite");
	self._update_visual();

func on_enter( body ):
	if(body.is_in_group('Player') && self.isopen):
		self.emit_signal('player_at_end_gate', body );
		self.get_tree().call_group(0,'Control','player_at_end_gate');

func _set_open(value):
	isopen = value
	self._update_visual();

func _get_open():
	return isopen

func _update_visual():
	if(self.spriteAnim):
		if(isopen):
			self.spriteAnim.set_frame(1);
		else:
			self.spriteAnim.set_frame(0);

