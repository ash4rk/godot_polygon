extends CanvasItem

class_name LineDrawer

var is_drawing = false
var start_point = Vector2()
var end_point = Vector2()

func _process(delta):
	if is_drawing:
		update()

func _draw():
	if is_drawing:
		draw_line(start_point, end_point, Color(1, 0, 0))
