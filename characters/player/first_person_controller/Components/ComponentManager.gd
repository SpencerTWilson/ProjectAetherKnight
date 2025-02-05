extends Node
class_name component_manager

var components : Dictionary = {}


func _ready():
	for child in get_children():
		if child is Component:
			components[child.name.to_lower()] = child
			if child.is_active:
				child.activate()
	

func _process(delta):
	for component_key in components:
		var component = components[component_key]
		if component.is_active:
			component.active(delta)

func  _physics_process(delta):
	for component_key in components:
		var component = components[component_key]
		if component.is_active:
			component.active_physics(delta)

func activate_component(component_name):
	components[component_name.to_lower()].activate()
	components[component_name.to_lower()].is_active = true

func deactivate_component(component_name):
	components[component_name.to_lower()].deactivate()
	components[component_name.to_lower()].is_active = false

func set_active_components(wanted_components):
	for component_key in components:
		var component = components[component_key]
		deactivate_component(component.name)
	
	if wanted_components != null:
		for component_name in wanted_components:
			activate_component(component_name)

func print_components(_is_active = false):
	for component_key in components:
		var component = components[component_key]
		if component.is_active || _is_active:
			print(component.name)
