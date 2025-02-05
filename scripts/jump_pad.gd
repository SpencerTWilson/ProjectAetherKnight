@tool
extends Node3D

@export var force : float = 20
@export var color : Color = Color(0,140,184)
@export var speed : float = 0

@onready var box_glow = $MeshInstance3D2.get_mesh().get_material()
@onready var particles = $GPUParticles3D.draw_pass_1.get_material()

func _on_area_3d_body_entered(body):
	if not Engine.is_editor_hint():
		if !body is StaticBody3D:
			body.velocity.y = force

func _ready():
	
	$MeshInstance3D2.set_mesh($MeshInstance3D2.get_mesh().duplicate())
	$GPUParticles3D.draw_pass_1 = $GPUParticles3D.draw_pass_1.duplicate()
	
	$MeshInstance3D2.get_mesh().set_material(box_glow.duplicate())
	$GPUParticles3D.draw_pass_1.set_material(particles.duplicate())


	box_glow = $MeshInstance3D2.get_mesh().get_material()
	particles = $GPUParticles3D.draw_pass_1.get_material()

func _process(delta):
	
	box_glow.albedo_color = color
	box_glow.emission = color
	
	particles.albedo_color = color
	particles.emission = color
	
