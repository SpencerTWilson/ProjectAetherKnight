extends Component

@onready var player = $"../.."

## particles to play while sprinting 
@export var particles : GPUParticles3D

func active(_delta):
	if Input.is_action_just_pressed("sprint"):
		player.speed += player.base_speed * (player.sprint_mult - 1.)
	
	if Input.is_action_just_released("sprint"):
		player.speed -= player.base_speed * (player.sprint_mult - 1.)
	
	if player.walk_input.length() > 0.1 && Input.is_action_pressed("sprint"):
		particles.emitting = true
	else:
		particles.emitting = false
