extends Panel

func _ready():
	$GridContainer/SpriteSpawnerBtn.pressed.connect(_on_sprite_spawner_btn)
	$GridContainer/RigidBodySpawnerBtn.pressed.connect(_on_rigidbody_spawner_btn)
	$GridContainer/ServerSpawnerBtn.pressed.connect(_on_server_spawner_btn)
	$GridContainer/SpriteBWBtn.pressed.connect(_on_sprite_bw_btn)
	$GridContainer/RigidBodyBWBtn.pressed.connect(_on_rigidbody_bw_btn)
	$GridContainer/ServerBWBtn.pressed.connect(_on_server_bw_btn)
	$GridContainer/SpriteGlowBtn.pressed.connect(_on_sprite_glow_btn)
	$GridContainer/RigidBodyGlowBtn.pressed.connect(_on_rigidbody_glow_btn)
	$GridContainer/ServerGlowBtn.pressed.connect(_on_server_glow_btn)
	$GridContainer/SpriteWorldEnvBtn.pressed.connect(_on_sprite_world_env_btn)
	$GridContainer/RigidBodyWorldEnvBtn.pressed.connect(_on_rigidbody_world_env_btn)
	$GridContainer/ServerWorldEnvBtn.pressed.connect(_on_server_world_env_btn)

func _on_sprite_spawner_btn():
	get_tree().change_scene_to_file("res://sprite_spawner.tscn")

func _on_rigidbody_spawner_btn():
	get_tree().change_scene_to_file("res://rigidbody_spawner.tscn")

func _on_server_spawner_btn():
	pass

func _on_sprite_bw_btn():
	get_tree().change_scene_to_file("res://sprites_with_bw_shader.tscn")

func _on_rigidbody_bw_btn():
	get_tree().change_scene_to_file("res://rigidbody_with_bw_shader.tscn")

func _on_server_bw_btn():
	pass

func _on_sprite_glow_btn():
	get_tree().change_scene_to_file("res://sprites_with_glow_shader.tscn")

func _on_rigidbody_glow_btn():
	get_tree().change_scene_to_file("res://rigidbody_with_glow_shader.tscn")

func _on_server_glow_btn():
	pass

func _on_sprite_world_env_btn():
	get_tree().change_scene_to_file("res://sprites_with_world_env.tscn")

func _on_rigidbody_world_env_btn():
	get_tree().change_scene_to_file("res://rigidbody_with_world_env.tscn")

func _on_server_world_env_btn():
	pass
