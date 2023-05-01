extends StaticBody2D

var sync_is_active: bool = false
var sync_grow_target: CharacterBody2D = null

func _process(_delta):
	queue_redraw()

func _on_area_2d_body_entered(body):
	if body.is_in_group("characters") and not sync_is_active:
		sync_grow_target = body
		body.get_node("Sprite2D").modulate = Color(1.0, 0.2, 0.3, 1)
		sync_is_active = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("characters"):
		sync_grow_target = null
		body.get_node("Sprite2D").modulate = Color(1.0, 1.0, 1.0, 1)
		sync_is_active = false


func _draw() -> void:
	if sync_grow_target != null:
		var from = Vector2(0, 0)
		var to = sync_grow_target.position - get_global_position()
		var lenght = to.distance_to(from)
		from = from.normalized()
		to = to.normalized() * lenght
		draw_line(from, to, Color.FOREST_GREEN, 8.0)
