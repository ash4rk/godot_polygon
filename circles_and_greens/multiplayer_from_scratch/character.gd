extends CharacterBody2D

@export var speed = 400

func _ready():
	position = $Networking.sync_position
	if str(name).is_valid_int():
		$Networking/MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())

func _physics_process(_delta):
	if !is_local_authority():
		if not $Networking.processed_position:
			position = $Networking.sync_position
			$Networking.processed_position = true
		velocity = $Networking.sync_velocity
		
		move_and_slide()
		return
	
	var target = get_global_mouse_position()
	velocity = position.direction_to(target) * speed
	#look_at(target)
	if position.distance_to(target) > 10:
		move_and_slide()

	$Networking.sync_position = position
	$Networking.sync_velocity = velocity

func is_local_authority():
	return $Networking/MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id()
