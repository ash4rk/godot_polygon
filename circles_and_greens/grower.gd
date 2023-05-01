extends StaticBody2D

var sync_is_active: bool = false
var grow_target: CharacterBody2D = null

func _on_area_2d_body_entered(body):
	if body.is_in_group("characters") and not sync_is_active:
		body.get_node("Sprite2D").modulate = Color(1.0, 0.2, 0.3, 1)
		sync_is_active = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("characters"):
		body.get_node("Sprite2D").modulate = Color(1.0, 1.0, 1.0, 1)
		sync_is_active = false
