extends Node

const DEFAULT_PORT = 10567
const MAX_PEERS = 10
var players = {}
var player_name

func _ready():
	multiplayer.peer_connected.connect(self._player_connected)
	multiplayer.peer_disconnected.connect(self._player_disconnected)
	multiplayer.connected_to_server.connect(self._connected_ok)
	multiplayer.connection_failed.connect(self._connected_fail)
	multiplayer.server_disconnected.connect(self._server_disconnected)

func start_server():
	player_name = "Server"
	var host = ENetMultiplayerPeer.new()
	
	var err = host.create_server(DEFAULT_PORT, MAX_PEERS)
	
	if(err!=OK):
		join_server()
		return
	
	multiplayer.set_multiplayer_peer(host)
	
	spawn_player(1)
	
func join_server():
	player_name = 'Client'
	var host    = ENetMultiplayerPeer.new()
	
	host.create_client('127.0.0.1', DEFAULT_PORT)
	multiplayer.set_multiplayer_peer(host)
	
func _player_connected(id):
	pass
	
func _player_disconnected(id):
	unregister_player(id)
	rpc("unregister_player", id)
	
func _connected_ok():
	rpc_id(1, "user_ready", multiplayer.get_unique_id(), player_name)
	
func _connected_fail():
	print("connected fail")

@rpc("call_remote")
func user_ready(id, player_name):
	if get_tree().is_network_server():
		rpc_id(id, "register_in_game")

@rpc("call_remote")
func register_in_game():
	rpc("register_new_player", multiplayer.get_unique_id(), player_name)
	register_new_player(multiplayer.get_unique_id(), player_name)
	
func _server_disconnected():
	quit_game()

@rpc("call_remote")
func register_new_player(id, name):
	if get_tree().is_network_server():
		rpc_id(id, "register_new_player", 1, player_name)
		
		for peer_id in players:
			rpc_id(id, "register_new_player", peer_id, players[peer_id])
			
	players[id] = name
	spawn_player(id)

@rpc("call_remote")
func register_player(id, name):
	if get_tree().is_network_server():
		rpc_id(id, "register_player", 1, player_name)
		
		for peer_id in players:
			rpc_id(id, "register_player", peer_id, players[peer_id])
			rpc_id(peer_id, "register_player", id, name)
			
	players[id] = name
	
@rpc("call_remote")
func unregister_player(id):
	get_node("/root/" + str(id)).queue_free()
	players.erase(id)
	
func quit_game():
	get_tree().set_network_peer(null)
	players.clear()
	
func spawn_player(id):
	var player_scene = preload("res://player.tscn")
	var player       = player_scene.instantiate()
	
	player.set_name(str(id))
	
	player.synced_position = Vector2(182, 163)
#	player.set_player_name(player_name if p_id == multiplayer.get_unique_id() else players[p_id])
	player.set_random_color()
	get_parent().get_node("Players").add_child(player)
	

