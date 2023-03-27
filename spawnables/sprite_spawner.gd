extends Node

const SIMPLE_SPRITE = preload("res://spawnables/simple_sprite.tscn")
@onready var Log : RichTextLabel = $CanvasLayer/LogBG/Log
var sprite_numbers: int = 500

func _print_log(text_value : String) -> void:
	Log.text += text_value + "\n"

func _ready():
	_print_log("Scene initialized")
	_print_log("Window size: " + str(DisplayServer.window_get_size()))

func _on_spawn_sprite_button_button_up():
	
	for i in sprite_numbers:
		var simple_sprite_instance = SIMPLE_SPRITE.instantiate()
		$Level.add_child(simple_sprite_instance)
		var x_screen = DisplayServer.window_get_size().x
		var y_screen = DisplayServer.window_get_size().y
		simple_sprite_instance.global_position = Vector2(randf_range(0, x_screen),randf_range(0, y_screen))

	_print_log("Added " + str(sprite_numbers) + " simple sprites")

func _on_h_slider_value_changed(value):
	sprite_numbers = value
	$CanvasLayer/HSlider/SizeLabel.text = "Number of objects: " + str(value)
