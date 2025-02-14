extends Node
class_name ShellManager

var active_shells: Array[Shell] = []
var shell_scene: PackedScene = preload("res://characters/shells/shell.tscn")

func _ready():
	MultiplayerManager.stable_player_data_updated.connect(_update_shells)
	MultiplayerManager.player_disconnected.connect(_remove_shell)

func _update_shells(peer_id, data_key):
	#Only update if visuals need to change
	#Streamed vars will be handled by the shell itself
	#Probably will have any cosmetic changes here too
	if !data_key == "class" and data_key != "cosmetics":
		return
	
	#find the proper shell and update
	for shell in active_shells:
		if shell.player_id == peer_id:
			shell._update()
			return
	
	#if we don't yet have a shell make one
	if MultiplayerManager.stable_player_data[peer_id]["class"] != null:
		_create_new_shell(peer_id)

func _create_new_shell(peer_id: int):
	var new_shell: Shell = shell_scene.instantiate()
	new_shell.player_id = peer_id
	new_shell.manager = self
	add_child(new_shell)

func _remove_shell(peer_id: int):
	for shell in active_shells:
		if shell.player_id == peer_id:
			shell.queue_free()
			active_shells.erase(shell)
