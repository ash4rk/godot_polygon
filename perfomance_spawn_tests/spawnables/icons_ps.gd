extends Node2D

var ICONS_COUNT = 0
const SPEED_MIN = 20
const SPEED_MAX = 80

const icon_image = preload("res://common/icon.svg")

var icons := []
var shape


class Icon:
	var position = Vector2()
	var body = RID()


func _ready():
	shape = PhysicsServer2D.circle_shape_create()
	PhysicsServer2D.shape_set_data(shape, 8)

	for _i in ICONS_COUNT:
		var icon = Icon.new()
		icon.body = PhysicsServer2D.body_create()

		PhysicsServer2D.body_set_space(icon.body, get_world_2d().get_space())
		PhysicsServer2D.body_add_shape(icon.body, shape)
		PhysicsServer2D.body_set_collision_mask(icon.body, 0)
		
		icon.position = Vector2(
			randf_range(0, get_viewport_rect().size.x),
			randf_range(0, get_viewport_rect().size.y)
		)
		var transform2d = Transform2D()
		transform2d.origin = icon.position
		PhysicsServer2D.body_set_state(icon.body, PhysicsServer2D.BODY_STATE_TRANSFORM, transform2d)

		icons.push_back(icon)


func _process(_delta):
	queue_redraw()


func _physics_process(delta):
	var transform2d = Transform2D()
	var offset = get_viewport_rect().size.x + 16
	for icon in icons:
		if icon.position.x < -16:
			icon.position.x = offset

		transform2d.origin = icon.position
		PhysicsServer2D.body_set_state(icon.body, PhysicsServer2D.BODY_STATE_TRANSFORM, transform2d)

func _draw():
	var offset = -icon_image.get_size() * 0.05
	for icon in icons:
		draw_texture(icon_image, icon.position + offset)


func _exit_tree():
	for icon in icons:
		PhysicsServer2D.free_rid(icon.body)

	PhysicsServer2D.free_rid(shape)
	icons.clear()
