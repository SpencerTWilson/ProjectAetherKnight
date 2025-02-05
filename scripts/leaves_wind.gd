extends Node3D

@onready var leaves = $GPUParticles3D
@export var wind_noise : Noise
@export var wind_scale = 1
@export var wind_speed = 0.1

var wanted_rotation = Vector3.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	wanted_rotation.x = sin(Time.get_ticks_msec()/200) / 100.
	wanted_rotation.y = sin((Time.get_ticks_msec()/200) * 24.33) / 70.
	leaves.position.z = lerp(position.z, leaves.position.z + sin(Time.get_ticks_msec()/200) / 100., 0.1)
	leaves.rotation_degrees = leaves.rotation_degrees.slerp(wanted_rotation * wind_scale, 0.05)
	leaves.rotation_degrees = leaves.rotation_degrees.slerp(Vector3.ZERO, wind_speed)
