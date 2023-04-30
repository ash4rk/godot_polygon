extends Node

@onready var character = get_parent()

var sync_position : Vector2:
	set(value):
		sync_position = value
		processed_position = false
var sync_velocity : Vector2

var processed_position : bool


var sync_level: float = 1.0 : set = _set_sync_level
var sync_is_dead: bool = false
var sync_is_grows: bool = false
var sync_is_damaged: bool = false

func _set_sync_level(value):
	if value < 0.5:
		sync_is_dead = true
		print("Player Dead!")
		get_parent().queue_free()
		return
	sync_level = value
	character.scale = Vector2(sync_level, sync_level)
	character.speed = character.INIT_SPEED / sync_level

func _process(delta):
	if sync_is_grows:
		sync_level += delta * character.GROW_SPEED
	if sync_is_damaged:
		sync_level -= delta * character.GROW_SPEED
