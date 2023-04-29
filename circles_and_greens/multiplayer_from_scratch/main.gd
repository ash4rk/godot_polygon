extends Node

const IP_ADDRESS = "localhost"
const PORT_ADDRESS = 10567

#example of user args
#++ --server --port=10567
#func _enter_tree():
#	if OS.get_cmdline_user_args().has("--server"):
#		start_network(true)
#	else:
#		start_network(false)


func start_network(is_server: bool) -> void:
	var peer = ENetMultiplayerPeer.new()
	if is_server:
		multiplayer.peer_connected.connect(self._on_peer_connected)
		multiplayer.peer_disconnected.connect(self._on_peer_disconnected)
		peer.create_server(PORT_ADDRESS)
		print("Server created!")
	else:
		peer.create_client(IP_ADDRESS, PORT_ADDRESS)
		print("Client created!")
	
	multiplayer.set_multiplayer_peer(peer)

func _on_client_button_pressed():
	start_network(false)
	$Menu.visible = false

func _on_host_button_pressed():
	start_network(true)
	$Menu.visible = false

func _on_peer_connected(peer_id: int):
	create_player(peer_id)

func _on_peer_disconnected(peer_id: int):
	destroy_player(peer_id)

func create_player(peer_id) -> void:
	var p = preload("res://multiplayer_from_scratch/character.tscn").instantiate()
	p.name = str(peer_id)
	$Players.add_child(p)

func destroy_player(peer_id) -> void:
	$Players.get_node(str(peer_id)).queue_free()
