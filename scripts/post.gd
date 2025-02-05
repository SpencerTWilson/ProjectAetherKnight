extends Node3D

@onready var animator = $Post/AnimationPlayer
@export var particle_center : GPUParticles3D
@export var particle_up : GPUParticles3D
@export var particle_down : GPUParticles3D
@export var particle_left : GPUParticles3D
@export var particle_right : GPUParticles3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !animator.is_playing():
		animator.play("Idle")
	

func hit(dir):
	animator.stop()
	animator.play("Hit")
	match dir:
		"center":
			particle_center.restart() 
			particle_center.emitting = true
		"left":
			particle_right.restart() 
			particle_right.emitting = true
		"right":
			particle_left.restart() 
			particle_left.emitting = true
		"down":
			particle_up.restart() 
			particle_up.emitting = true
		"up":
			particle_down.restart() 
			particle_down.emitting = true
		
	print(dir)


func _on_area_3d_slashed(dir):
	hit(dir)
	print("hit ", dir)
