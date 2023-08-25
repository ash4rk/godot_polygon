extends Area2D

onready var previous_position = position
var wire = null

func on_drop():
#	position = position.snapped(Vector2(64,64))
#	yield(get_tree(),"idle_frame")
#	yield(get_tree(),"idle_frame")
	print("on_drop")

func on_drag_start():
	print("start")
	wire = Sprite.new()
	wire.set_texture(preload("res://icon.png"))
	wire.modulate = Color.red
	get_parent().add_child(wire)
