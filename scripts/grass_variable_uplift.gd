@tool
extends Node3D

@export var power : float = 15
@export var color : Color = Color(0,0,0)
@export var speed : float = 9.5
@export var light : DirectionalLight3D

var point
@onready var grass = $Plane.get_surface_override_material(0)

func _ready():
	if light != null:
		point = light.position
	else:
		point = Vector3.ZERO

func _process(delta):
	grass.set("shader_parameter/power",speed)
	grass.set("shader_parameter/speed",power)
	grass.set("shader_parameter/grass_color",color)
	grass.set("shader_parameter/point", point)
