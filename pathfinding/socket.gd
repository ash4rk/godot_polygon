extends TextureButton

class_name Socket

var line_draft: Line2D


func _on_Sprite_button_down():
	print("MouseDOWN")
	line_draft = Line2D.new()
	line_draft.add_point($center.global_position)
	line_draft.add_point($center.global_position)
	get_parent().add_child(line_draft)


func _process(delta):
	if line_draft and Input.is_mouse_button_pressed(BUTTON_LEFT):
		line_draft.points[1] = get_global_mouse_position()


func _on_Sprite_button_up():
	print("MouseUP")
	var end = line_draft.points[1]
	
	var viewport = get_viewport()
	var mouse_position = viewport.get_mouse_position()
	
	if MouseController.object_under.is_in_group("sockets"):
		
		print("hi")
	else:
		line_draft.queue_free()
	line_draft = null


func _on_socket_mouse_entered():
	MouseController.object_under = self
	print("button under mouse")


func _on_socket_mouse_exited():
	MouseController.object_under = null
	print("no button")


func _on_Area2D_body_entered(body):
	if body is Line2D:
		print("HI!")


func _on_Area2D_input_event(viewport, event, shape_idx):
#	if event is InputEventMouseButton:
	print("Click Event")
