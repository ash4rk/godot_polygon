extends Node

signal mode_changed(new_value)

enum MouseMode {DRAG, DRAW_PATHS}

var mode = MouseMode.DRAG setget _set_mode
var object_under: Node

func _set_mode(new_value):
	mode = new_value
	emit_signal("mode_changed", new_value)


func _on_drag_mode_button_pressed():
	mode = MouseMode.DRAG


func _on_draw_paths_mode_button_pressed():
	mode = MouseMode.DRAW_PATHS
