extends Button

@export_file("*.tscn") var next_scene: String
@export var leave_multiplayer: bool = true 
#turn this off if you are switching scenes but wish to remain connected.
#You want to disconnect say if you go back to the titlescreen. 
#There is no harm is disconnecting if you aren't connected.

func _pressed() -> void:
	get_tree().change_scene_to_file(next_scene)
	MultiplayerManager.leave_game()
