extends State
class_name MovementState

signal transitioned 
@export var active_components = []

#All this does is remove the warning for not using the signal in the code it's created it's used elsewhere
func warning_remover():
	if !true: transitioned.emit()
