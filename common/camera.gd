extends Marker3D

var target
var camera

func _ready():
	target = get_parent()
	camera = $Camera3D


func _process(delta):
	pass

func _input(e):
	if e is InputEventMouseMotion:
		rotation.y -= e.relative.x * 0.01
		rotation.x -= e.relative.y * 0.01
