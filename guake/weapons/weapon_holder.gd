extends Node3D

enum WEAPONS {PISTOL, ASSAULT_RIFLE, SHOTGUN, BAZOOKA, SNIPER_RIFLE}

var current_weapon = 1

func _input(_event):
	if Input.is_action_pressed("get_pistol"):
		current_weapon = 0
	if Input.is_action_pressed("get_assault_rifle"):
		current_weapon = 1
	if Input.is_action_pressed("get_shotgun"):
		current_weapon = 2
	if Input.is_action_pressed("get_bazooka"):
		current_weapon = 3
	if Input.is_action_pressed("get_sniper_rifle"):
		current_weapon = 4
	weapon_switch()

func _ready():
	for child in get_child_count():
		get_child(child).hide()
		get_child(child).process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	get_child(current_weapon).show()
	get_child(current_weapon).process_mode = Node.PROCESS_MODE_INHERIT
 
func weapon_switch():
	for child in get_child_count():
		get_child(child).hide()
		get_child(child).process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	get_child(current_weapon).show()
	get_child(current_weapon).process_mode = Node.PROCESS_MODE_INHERIT

