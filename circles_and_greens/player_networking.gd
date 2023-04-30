extends Node2D

@onready var character = get_parent()

@export var target := Vector2(0.0, 0.0)

func update():
	target = get_global_mouse_position()

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
