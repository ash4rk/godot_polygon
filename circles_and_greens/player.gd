extends CharacterBody2D

@export var speed = 400
var level: float = 1.0

func _physics_process(delta):
	var target = get_global_mouse_position()
	velocity = position.direction_to(target) * speed
	look_at(target)
	if position.distance_to(target) > 10:
		move_and_slide()

func _process(delta):
	$LevelLabel.text = str(level)
