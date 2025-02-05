extends Component
@onready var player = $"../.."

func active(delta):
	
	player.velocity.x = lerp(player.velocity.x, 0.0, player.FRICTION * delta)
	player.velocity.z = lerp(player.velocity.z, 0.0, player.FRICTION * delta)
	
