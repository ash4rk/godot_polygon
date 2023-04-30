extends CharacterBody2D

@export var speed = 400
@export var sync_position := Vector2()

@onready var inputs = $Networking
const INIT_SPEED = 400
const GROW_SPEED = 0.5

func _ready():
	position = sync_position
	if str(name).is_valid_int():
		$Networking/MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())


func _physics_process(_delta):
	
	if multiplayer.multiplayer_peer == null or str(multiplayer.get_unique_id()) == str(name):
		# The client which this player represent will update the controls state, and notify it to everyone.
		inputs.update()

	if multiplayer.multiplayer_peer == null or is_multiplayer_authority():
		
		# The server updates the position that will be notified to the clients.
		sync_position = position
	else:
		# The client simply updates the position to the last known one.
		position = sync_position

	velocity = position.direction_to(inputs.target) * speed
	#look_at(target)
	if position.distance_to(inputs.target) > 10:
		move_and_slide()


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

