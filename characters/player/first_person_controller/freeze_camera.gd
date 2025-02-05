extends State

var is_active : bool

func update(_delta):
	if Input.is_action_just_pressed("escape"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func enter():
	is_active = true

func exit():
	is_active = false
