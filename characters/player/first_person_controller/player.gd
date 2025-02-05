extends CharacterBody3D

var walk_input

@export var base_speed : float

@onready var speed = base_speed

## Multipier applied to base Speed to calculate speed
@export var sprint_mult : float

## Amount the player lerps toward zero velocity 
@export var FRICTION = 0.5

@export var AIR_FRICTION = 0.5

##force of impulse when jumped
@export var JUMP_POWER = 4.5


@onready var movement_state_machine = $MovementStateMachine
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	walk_input = Input.get_vector("walk_left", "walk_right", "walk_forward", "walk_backward")
	
	move_and_slide()
