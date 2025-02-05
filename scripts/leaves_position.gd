@tool
extends GPUParticles3D

var prev_pos = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position != prev_pos || prev_pos == null:
		draw_pass_1.surface_get_material(0).set_shader_parameter("point", global_position)
		prev_pos = global_position
