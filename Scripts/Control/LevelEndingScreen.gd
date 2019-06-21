extends Control

# class member variables go here, for example:
export(int) var score = 0
export(int) var time = 0


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	triggerConfetti();
	pass
	
func triggerConfetti():
	$"Container/Effects/Confetti/Confetti Left".emitting =false;
	$"Container/Effects/Confetti/Confetti Right".emitting =false;
	$"Container/Effects/Confetti/Confetti Left".emitting =true;
	$"Container/Effects/Confetti/Confetti Right".emitting =true;


