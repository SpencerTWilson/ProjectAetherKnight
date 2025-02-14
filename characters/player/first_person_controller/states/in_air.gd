extends MovementState
class_name InAir

@onready var player = $"../.."

## node that contains the camera's X rotation
@export var camera_x : Node3D

## particles that are emit when hitting the ground
@export var land_particles : GPUParticles3D




func update(delta):
	var walk_input = player.walk_input
	var direction = (camera_x.transform.basis * Vector3(walk_input.x, 0, walk_input.y)).normalized()
	
	player.velocity += direction * (player.speed / 4) * delta
	
	
	player.velocity.y -= player.gravity * delta
	
	if player.is_on_floor():
		land_particles.emitting = true
		transitioned.emit(self,"idle")
