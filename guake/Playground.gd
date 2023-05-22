extends Node

const Player = preload("res://fps_controllers/fpsplayer/player.tscn")
const PORT = 8000
var enet_peer = ENetMultiplayerPeer.new()

func _ready():
	$CanvasLayer/MainMenu.start_client.connect(_on_start_client)
	$CanvasLayer/MainMenu.start_server.connect(_on_start_server)

func _on_start_client():
	enet_peer.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_peer

func _on_start_server():
	enet_peer.create_server(PORT)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	$ServerCam.current = true

func add_player(peer_id):
	var player = Player.instantiate()
	player.name = str(peer_id)
	add_child(player)
#	player.position = $PlayerSpawner.position
#	if player.is_multiplayer_authority():
#		player.health_changed.connect(update_health_bar)

func remove_player(peer_id):
	var player = get_node_or_null(str(peer_id))
	if player:
		player.queue_free()

#func update_health_bar(health_value):
#	health_bar.value = health_value

func _on_multiplayer_spawner_spawned(_node):
#		if node.is_multiplayer_authority():
#			node.health_changed.connect(update_health_bar)
	pass
