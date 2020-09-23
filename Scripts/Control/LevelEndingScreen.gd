extends Node2D

# class member variables go here, for example:
export(int) var score = 0
export(int) var time = 0


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$BackgroundBlur/AnimationPlayer.connect("animation_finished",self,"fire_next_level");
	self.update();

func update():
	self.scale.x = get_viewport().size.x / 1024;
	self.scale.y = get_viewport().size.y / 600; 
	self.find_node("Score",true).score = self.score;
	self.find_node("Clock",true).timePassed = self.time;
	
func triggerConfetti():
	$"Container/Effects/Confetti/Confetti Left".restart();
	$"Container/Effects/Confetti/Confetti Right".restart();
	$"Container/Effects/Confetti/Confetti Left".emitting =true;
	$"Container/Effects/Confetti/Confetti Right".emitting =true;



func _on_next_pressed():
	self.get_tree().call_group('Control','next_level_requested');
	$BackgroundBlur/AnimationPlayer.play("dissipate")

func fire_next_level( anim_name ):
	if(anim_name == "dissipate"):
		self.hide();
