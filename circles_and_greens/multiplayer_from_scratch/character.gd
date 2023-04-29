extends CharacterBody2D


func _ready():
	position = $Networking.sync_position
	if str(name).is_valid_int():
		$Networking/MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())

func _physics_process(delta):
	pass
