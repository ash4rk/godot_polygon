extends Panel

func _ready():
	$VBoxContainer/GridContainer/SpriteSpawnerBtn.pressed.connect(_on_sprite_spawner_btn)
	$VBoxContainer/GridContainer/RigidBodySpawnerBtn.pressed.connect(_on_rigidbody_spawner_btn)
	$VBoxContainer/GridContainer/ServerSpawnerBtn.pressed.connect(_on_server_spawner_btn)
	$VBoxContainer/GridContainer/SpriteBWBtn.pressed.connect(_on_sprite_bw_btn)
	$VBoxContainer/GridContainer/RigidBodyBWBtn.pressed.connect(_on_rigidbody_bw_btn)
	$VBoxContainer/GridContainer/ServerBWBtn.pressed.connect(_on_server_bw_btn)
	$VBoxContainer/GridContainer/SpriteGlowBtn.pressed.connect(_on_sprite_glow_btn)
	$VBoxContainer/GridContainer/RigidBodyGlowBtn.pressed.connect(_on_rigidbody_glow_btn)
	$VBoxContainer/GridContainer/ServerGlowBtn.pressed.connect(_on_server_glow_btn)
	$VBoxContainer/GridContainer/SpriteWorldEnvBtn.pressed.connect(_on_sprite_world_env_btn)
	$VBoxContainer/GridContainer/RigidBodyWorldEnvBtn.pressed.connect(_on_rigidbody_world_env_btn)
	$VBoxContainer/GridContainer/ServerWorldEnvBtn.pressed.connect(_on_server_world_env_btn)
	#3D
	$VBoxContainer/ThreeDimGridContainer/Simple3DBtn.pressed.connect(_on_simple_3D_btn)
	$VBoxContainer/ThreeDimGridContainer/ThreeDimWithLightsBtn.pressed.connect(_on_three_dim_with_lights_btn)
	$VBoxContainer/ThreeDimGridContainer/ThreeDimBWShaderBtn.pressed.connect(_on_three_dim_bw_shader_btn)
	

func _on_sprite_spawner_btn():
	get_tree().change_scene_to_file("res://sprite_spawner.tscn")

func _on_rigidbody_spawner_btn():
	get_tree().change_scene_to_file("res://rigidbody_spawner.tscn")

func _on_server_spawner_btn():
	get_tree().change_scene_to_file("res://server_spawner.tscn")

func _on_sprite_bw_btn():
	get_tree().change_scene_to_file("res://sprites_with_bw_shader.tscn")

func _on_rigidbody_bw_btn():
	get_tree().change_scene_to_file("res://rigidbody_with_bw_shader.tscn")

func _on_server_bw_btn():
	get_tree().change_scene_to_file("res://server_with_bw_shader.tscn")

func _on_sprite_glow_btn():
	get_tree().change_scene_to_file("res://sprites_with_glow_shader.tscn")

func _on_rigidbody_glow_btn():
	get_tree().change_scene_to_file("res://rigidbody_with_glow_shader.tscn")

func _on_server_glow_btn():
	get_tree().change_scene_to_file("res://server_with_glow_shader.tscn")

func _on_sprite_world_env_btn():
	get_tree().change_scene_to_file("res://sprites_with_world_env.tscn")

func _on_rigidbody_world_env_btn():
	get_tree().change_scene_to_file("res://rigidbody_with_world_env.tscn")

func _on_server_world_env_btn():
	get_tree().change_scene_to_file("res://server_with_world_env.tscn")

func _on_simple_3D_btn():
	get_tree().change_scene_to_file("res://simple_3d_level.tscn")

func _on_three_dim_with_lights_btn():
	get_tree().change_scene_to_file("res://three_dim_with_light.tscn")
	
func _on_three_dim_bw_shader_btn():
	get_tree().change_scene_to_file("res://three_dim_bw_shader.tscn")
