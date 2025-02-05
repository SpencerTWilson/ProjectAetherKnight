extends State

@export var x_rotation : Node3D
@export var y_rotation : Node3D
@export var sensitivity : float
var is_active : bool

func _unhandled_input(event):
	if is_active:
		if event is InputEventMouseMotion:
			x_rotation.rotate_y(-event.relative.x * sensitivity)
			y_rotation.rotate_x(-event.relative.y * sensitivity)
			y_rotation.rotation_degrees.x = clamp(y_rotation.rotation_degrees.x, -90, 90)

func update(_delta):
	if Input.is_action_just_pressed("escape"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func enter():
	is_active = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func exit():
	is_active = false
