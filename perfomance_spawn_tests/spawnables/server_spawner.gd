extends Node

const SIMPLE_SPRITE = preload("res://spawnables/simple_sprite.tscn")
@onready var Log : RichTextLabel = $CanvasLayer/LogBG/Log
var number_of_objects: int = 500

func _print_log(text_value : String) -> void:
	Log.text += text_value + "\n"

func _ready():
	_print_log("Scene initialized")
	_print_log("Window size: " + str(DisplayServer.window_get_size()))

func _on_spawn_sprite_button_button_up():
	$Level/Icons._exit_tree()
	$Level/Icons.ICONS_COUNT = number_of_objects
	$Level/Icons._ready()
	_print_log(str(number_of_objects) + " objects was initialized")


func _on_h_slider_value_changed(value):
	number_of_objects = value
	$CanvasLayer/HSlider/SizeLabel.text = "Number of objects: " + str(value)
