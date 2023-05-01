extends CPUParticles2D

func _process(_delta):
	if !emitting:
		queue_free()
