extends CharacterBody2D

class_name Circle

const MOTION_SPEED = 90.0
@export var synced_position := Vector2()

@onready var inputs = $Inputs

const INIT_SPEED = 400
const GROW_SPEED = 0.5
@export var speed = 400
@export var level: float = 1.0 : set = _set_level

var _is_dead: bool = false
var _is_grows: bool = false
var _is_damaged: bool = false

func _ready():
	position = synced_position
	if str(name).is_valid_int():
		get_node("Inputs/InputsSync").set_multiplayer_authority(str(name).to_int())

func _physics_process(delta):
	if multiplayer.multiplayer_peer == null or str(multiplayer.get_unique_id()) == str(name):
		# The client which this player represent will update the controls state, and notify it to everyone.
		inputs.update()
		
	if multiplayer.multiplayer_peer == null or is_multiplayer_authority():
		
		# The server updates the position that will be notified to the clients.
		synced_position = position
	else:
		
		# The client simply updates the position to the last known one.
		position = synced_position
		
	velocity = inputs.motion * MOTION_SPEED
	move_and_slide()


func _process(delta):
	$LevelLabel.text = str(level).pad_decimals(2)
	if _is_grows:
		level += delta * GROW_SPEED
	if _is_damaged:
		level -= delta * GROW_SPEED

func _on_area_2d_body_entered(body):
	if body.is_in_group("players") and body != self:
		_is_damaged = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("players"):
		_is_damaged = false

func _set_level(value):
	if value < 1.0:
		_is_dead = true
		queue_free()
		return
	level = value
	scale = Vector2(level, level)
	speed = INIT_SPEED /level

func _on_area_2d_area_entered(area):
	var body = area.get_parent()
	if body.is_in_group("growers") and !body.is_active:
		_is_grows = true
		body.is_active = true

func _on_area_2d_area_exited(area):
	var body = area.get_parent()
	if body.is_in_group("growers"):
		_is_grows = false
		body.is_active = false


func set_player_name(value):
	get_node("NameLabel").text = value
