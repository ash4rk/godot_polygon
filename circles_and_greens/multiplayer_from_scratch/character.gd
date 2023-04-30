extends CharacterBody2D

@export var speed = 400

const INIT_SPEED = 400
const GROW_SPEED = 0.5

func _ready():
	position = $Networking.sync_position
	if str(name).is_valid_int():
		$Networking/MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())

func _physics_process(_delta):
	if $Networking.sync_is_dead:
		return
	
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

func _process(_delta):
	$LevelLabel.text = str($Networking.sync_level).pad_decimals(2)

func is_local_authority():
	return $Networking/MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id()


func _on_area_2d_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("growers") and !body.is_active:
		$Networking.sync_is_grows = true
		body.is_active = true

func _on_area_2d_area_exited(area):
	var body = area.get_parent()
	if body.is_in_group("growers"):
		$Networking.sync_is_grows = false
		body.is_active = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("characters") and body != self:
		$Networking.sync_is_damaged = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("characters"):
		$Networking.sync_is_damaged = false

