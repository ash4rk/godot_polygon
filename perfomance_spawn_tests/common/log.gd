extends ColorRect

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_reset_button_pressed():
	get_tree().reload_current_scene()
