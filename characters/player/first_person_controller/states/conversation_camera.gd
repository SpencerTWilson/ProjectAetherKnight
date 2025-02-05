extends Component

@export var end_point : Node3D
@export var lerp_speed : float
@export var player_model : Node3D
@export var animation_player : AnimationPlayer
@export var camera : Camera3D

func update(_delta):
	if Input.is_action_just_pressed("escape"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	camera.position = lerp(camera.position, end_point, lerp_speed)

func enter():
	player_model.visible = true
	animation_player.play("idle")
