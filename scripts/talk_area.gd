extends Node3D

@export var camera_state_machine : Node
@export var talk_box : DialogueTextBox

func _on_area_3d_body_entered(body):
	if body is CharacterBody3D:
		talk_box.start()
