extends Node

@export var current_item : String
@export var items : Dictionary


func activate():
	register_items()
	pass


func deactivate():
	#called when a component is deactivated
	pass

func active(delta):
	#called every proccess call a component is active
	pass

func register_items():
	items.clear()
	for child in get_children():
		if child is PlayerItem:
			items[child.name] = child
	if items[current_item] == null:
		current_item == items.find_key(items.values()[0])
