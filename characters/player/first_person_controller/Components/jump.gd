extends Component

@onready var player = $"../.."
@export var particles : GPUParticles3D

func active(_delta):
	if Input.is_action_just_pressed("jump"):
		particles.emitting = true
		player.velocity.y += player.JUMP_POWER
	
	
