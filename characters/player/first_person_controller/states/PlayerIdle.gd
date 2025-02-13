extends MovementState
class_name PlayerIdle

var FRICTION 
var walk_input
@onready var player = $"../.."

func enter():
	FRICTION = player.FRICTION

func update(_delta):
	walk_input = player.walk_input
	
	if walk_input.length() != 0:
		transitioned.emit(self,"walk")
	
	if player.is_on_floor() == false:
		transitioned.emit(self,"inAir")
