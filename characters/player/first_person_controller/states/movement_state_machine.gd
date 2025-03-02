extends Node


var current_state : State

var states : Dictionary = {}

@export var initial_state : State

@onready var component_manager: ComponentManager = $"../Components"


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	current_state.update(delta)

func  _physics_process(delta):
	current_state.physics_update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		print("did not find state")
		return
	
	if current_state:
		current_state.exit()
	
	component_manager.set_active_components(new_state.active_components)
	
	new_state.enter()
	
	current_state = new_state

func transition(new_state_name):
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		print("did not find state")
		return
	
	if current_state:
		current_state.exit()
	
	component_manager.set_active_components(new_state.active_components)
	
	new_state.enter()
	
	current_state = new_state
