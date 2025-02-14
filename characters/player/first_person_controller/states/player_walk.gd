extends MovementState
class_name PlayerWalk

@onready var player = $"../.."

## node that contains the camera's X rotation
@export var camera_x : Node3D


func update(delta):
	var walk_input = player.walk_input
	var direction = (camera_x.transform.basis * Vector3(walk_input.x, 0, walk_input.y)).normalized()
	
	player.velocity += direction * player.speed * delta
	
	if walk_input.length() <= 0.1:
		transitioned.emit(self,"idle")
	
	if player.is_on_floor() == false:
		transitioned.emit(self,"inAir")
