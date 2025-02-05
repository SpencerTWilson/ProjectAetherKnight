extends Component

@onready var player = $"../.."

## player's collider 
@export var collision_shape : CollisionShape3D

@onready var default_size = collision_shape.shape.height

@onready var crouch_size = default_size / 2.

## how fast to lerp the crouch height
@export var time : float

## area above the collision shape to check to see if player can uncrouch
@export var area : Area3D

var StaticBodyCount = 0

func active(_delta):
	if Input.is_action_pressed("crouch"):
		if player.velocity.length() <= 10.:
			collision_shape.shape.height = lerp(collision_shape.shape.height, crouch_size, time)
	else:
		if area.get_overlapping_bodies() == []:
			collision_shape.shape.height = lerp(collision_shape.shape.height, default_size, time)
	
	if Input.is_action_just_pressed("crouch"):
		player.speed -= player.base_speed / 2
	if Input.is_action_just_released("crouch"):
		player.speed += player.base_speed / 2
