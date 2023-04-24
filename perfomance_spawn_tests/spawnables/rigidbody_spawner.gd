extends Node

const SIMPLE_RIGIDBODY = preload("res://spawnables/simple_rigid_body.tscn")
@onready var Log : RichTextLabel = $CanvasLayer/LogBG/Log
var sprite_numbers: int = 0
var object_size: = Vector2(1.0, 1.0)

func _print_log(text_value : String) -> void:
	Log.text += text_value + "\n"

func _ready():
	_print_log("Scene initialized")
	_print_log("Window size: " + str(DisplayServer.window_get_size()))

func _on_spawn_sprite_button_button_up():
	var simple_rigidbody_instance = SIMPLE_RIGIDBODY.instantiate()
	$Level.add_child(simple_rigidbody_instance)
	var x_screen = DisplayServer.window_get_size().x
	var y_screen = DisplayServer.window_get_size().y
	simple_rigidbody_instance.global_position = Vector2(randf_range(0, x_screen),randf_range(0, y_screen))
	sprite_numbers += 1
	simple_rigidbody_instance.get_node("./CollisionShape2D").scale = object_size
	_print_log("Added simple sprite " + str(sprite_numbers))

func _on_h_slider_value_changed(value):
	$CanvasLayer/HSlider/SizeLabel.text = "Size: " + str(value)
	object_size = Vector2(value, value)
