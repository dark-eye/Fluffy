extends Area2D

signal  player_at_end_gate

func _ready():
	self.connect("body_enter",self,'on_enter');
	pass

func on_enter( body ):
	if(body.is_in_group('Player')):
		self.emit_signal('player_at_end_gate', body );
		self.get_tree().call_group(0,'Control','player_at_end_gate');
