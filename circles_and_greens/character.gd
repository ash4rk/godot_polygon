extends CharacterBody2D

const EXPLOSION_SCENE = preload("res://explosion.tscn")

@export var speed = 400
@export var sync_position := Vector2()

@onready var inputs = $Networking
const INIT_SPEED = 400
const GROW_SPEED = 0.5

func _ready():
	position = sync_position
	set_random_color()
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

func is_local_authority():
	return $Networking/MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id()

func _process(_delta):
	$LevelLabel.text = str($Networking.sync_level).pad_decimals(2)

func _on_area_2d_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("growers") and !body.sync_is_active:
		$Networking.sync_is_grows = true
#		body.is_active = true
	if body.is_in_group("killers"):
		$Networking.sync_is_grows = true
		$Networking.sync_is_damaged = true

func _on_area_2d_area_exited(area):
	var body = area.get_parent()
	if body.is_in_group("growers"):
		$Networking.sync_is_grows = false
#		body.is_active = false
	if body.is_in_group("killers"):
		$Networking.sync_is_grows = false
		$Networking.sync_is_damaged = false


func _on_area_2d_body_entered(body):
	if body.is_in_group("characters") and body != self:
		$Networking.sync_is_damaged = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("characters"):
		$Networking.sync_is_damaged = false

func killed() -> void:
	var explosion = EXPLOSION_SCENE.instantiate()
	explosion.position = self.position
	explosion.color = self.modulate
	get_tree().get_current_scene().add_child(explosion)
	explosion.emitting = true
	visible = false
	position = get_tree().get_current_scene().get_random_spawn_point_pos()
	$Networking.sync_level = 1.0
	set_random_color()
	$Networking.sync_is_dead = false
	visible = true

func set_random_color() -> void:
	var colors = [Color(0.09020, 0.74510, 0.73333, 1.0),
		Color(0.89412, 0.34118, 0.018039, 1.0),
		Color(1.0, 0.78824, 0.07843, 1.0),
		Color(0.18039, 0.15686, 0.016471, 1.0),
		Color(0.46275, 0.69020, 0.25490, 1.0),
		Color(1.0, 0.78824, 1.0, 1.0),]
	randomize()
	self.modulate = colors[randi() % colors.size()]
