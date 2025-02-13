extends Node
class_name Component

@export var Manager : Node
@export var is_active : bool

func activate():
	#called when a component is activated
	pass


func deactivate():
	#called when a component is deactivated
	pass

func active(_delta):
	#called every proccess call a component is active
	pass

func active_physics(_delta):
	#called every physics_proccess call a component is active
	pass
