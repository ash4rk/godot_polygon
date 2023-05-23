extends CharacterBody3D

signal health_changed(health_value)

const GRAVITY = -24.8
const MAX_SPEED = 20
const JUMP_SPEED = 10
const ACCEL = 4.5

@onready var anim_player = $AnimationPlayer
@onready var raycast = $RotationHelper/PlayerEyes/RayCast3D

var health = 3

var dir = Vector3()

const DEACCEL= 16
const MAX_SLOPE_ANGLE = 40

var camera
var rotation_helper

var MOUSE_SENSITIVITY = 0.05

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

func _ready():
	if not is_multiplayer_authority(): return
	camera = $RotationHelper/PlayerEyes
	rotation_helper = $RotationHelper
	camera.current = true

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if not is_multiplayer_authority(): return
	
	process_input(delta)
	process_movement(delta)

func process_input(_delta):
	# ----------------------------------
	# Walking
	dir = Vector3()
	var cam_xform = camera.get_global_transform()

	var input_movement_vector = Vector2()

	if Input.is_action_pressed("forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("backward"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("right"):
		input_movement_vector.x += 1

	input_movement_vector = input_movement_vector.normalized()

	# Basis vectors are already normalized.
	dir += -cam_xform.basis.z * input_movement_vector.y
	dir += cam_xform.basis.x * input_movement_vector.x
	# ----------------------------------

	# ----------------------------------
	# Jumping
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_SPEED
	# ----------------------------------

	# ----------------------------------
	# Capturing/Freeing the cursor
	if Input.is_action_just_pressed("cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# ----------------------------------
	# Shooting
	if Input.is_action_just_pressed("shoot") \
			and anim_player.current_animation != "shoot":
		play_shoot_effects.rpc()
		if raycast.is_colliding() and raycast.get_collider().has_method("receive_damage"):
			var hit_player = raycast.get_collider()
			hit_player.receive_damage.rpc_id(hit_player.get_multiplayer_authority())
	# ----------------------------------

func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()

	velocity.y += delta * GRAVITY

	var hvel = velocity
	hvel.y = 0

	var target = dir
	target *= MAX_SPEED

	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.lerp(target, accel * delta)
	velocity.x = hvel.x
	velocity.z = hvel.z
	move_and_slide()

func _input(event):
	if not is_multiplayer_authority(): return
		
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg_to_rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		self.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rot

@rpc("call_local")
func play_shoot_effects():
	anim_player.stop()
	anim_player.play("shoot")
	$RotationHelper/PlayerEyes/Weapon/MuzzleFlash.restart()
	$RotationHelper/PlayerEyes/Weapon/MuzzleFlash.emitting = true

@rpc("any_peer")
func receive_damage():
	health -= 1
	if health <= 0:
		health = 3
		position = Vector3.ZERO
	health_changed.emit(health)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "shoot":
		anim_player.play("idle")
