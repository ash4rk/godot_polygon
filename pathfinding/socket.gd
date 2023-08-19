extends TextureButton

var line_draft: Line2D

func _on_Sprite_button_down():
	print("MouseDOWN")
	line_draft = Line2D.new()
	line_draft.add_point(rect_position)
	add_child(line_draft)

func _process(delta):
	if line_draft and Input.is_mouse_button_pressed(BUTTON_LEFT):
		line_draft.add_point(get_local_mouse_position())


func _on_Sprite_button_up():
	print("MouseUP")
