extends Component

@export var ui_node : ColorRect
@export var ui_node2 : ColorRect
@onready var player = $"../.."
@onready var shader = ui_node.material
@onready var shader2 = ui_node2.material
@onready var noise = ui_node.material.get_shader_parameter("noise")
@onready var noise2 = ui_node2.material.get_shader_parameter("noise")

func active(_delta):
	if player.velocity.length() >= 12:
		ui_node.visible = true
		shader.set_shader_parameter("line_density", remap(player.velocity.length(),0,20,0,0.4))
		noise.noise.fractal_lacunarity = pow(sin(Time.get_ticks_usec()/20000000.),2) + 1 * 4 
		shader.set_shader_parameter("noise", noise)
		
		ui_node2.visible = true
		shader2.set_shader_parameter("line_density", remap(player.velocity.length(),0,20,0,0.4))
		noise2.noise.fractal_lacunarity = pow(sin(Time.get_ticks_usec()/20000000.),2) + 1 * 4 
		shader2.set_shader_parameter("noise", noise2)
		
	else:
		ui_node.visible = false
		ui_node2.visible = false

func deactivate():
	ui_node.visible = false
	ui_node2.visible = false
