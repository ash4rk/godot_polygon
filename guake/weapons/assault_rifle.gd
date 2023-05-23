extends Weapon

func _process(delta):
	if not is_multiplayer_authority(): return
		
	if is_reloading:
		pass
	if ammo <= 0 and !is_reloading:
		can_fire = false
		reload()
	if Input.is_action_pressed("shoot") and can_fire:
		fire(delta)


func fire(_delta):
	play_shoot_effects.rpc()
	can_fire = false
	ammo -= ammo_per_shot
	if ray_cast.get_collider() != null and ray_cast.get_collider().is_in_group("players"):
		var hit_player = ray_cast.get_collider()
		hit_player.receive_damage.rpc_id(hit_player.get_multiplayer_authority())

	await get_tree().create_timer(firerate).timeout
	if ray_cast.is_colliding():
		_place_decal()

	if not is_reloading:
		can_fire = true

func _place_decal():
	pass
#	var col_point = ray_cast.get_collision_point()
#	var D = DECAL.instantiate()
#	get_tree().get_root().add_child(D)
#	D.global_transform.origin = col_point
#	var t = get_tree().create_tween()
#	t.tween_interval(1)
#	t.tween_callback(func():D.free())

@rpc("call_local")
func play_shoot_effects():
	anim_player.stop(true)
	anim_player.play("shoot")
	$MuzzleFlash.restart()
	$MuzzleFlash.emitting = true
