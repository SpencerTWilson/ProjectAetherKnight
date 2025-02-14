extends CharacterBody3D
class_name Shell

var manager: ShellManager
var player_id: int
var player_class: String = ""

func _update():
	if !MultiplayerManager.stable_player_data[player_id]["class"] != null:
		manager._remove_shell(player_id)
		return
	player_class = MultiplayerManager.stable_player_data[player_id]["class"]
	
#visuals only changes, ie anims, rotation, ect
func _process(delta: float) -> void:
	pass

#posiiton or any other physics affecting changes
func _physics_process(delta: float) -> void:
	pass
