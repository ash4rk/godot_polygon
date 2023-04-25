extends Circle

func _physics_process(_delta):
	var target = get_global_mouse_position()
	velocity = position.direction_to(target) * speed
	#look_at(target)
	if position.distance_to(target) > 10:
		move_and_slide()
