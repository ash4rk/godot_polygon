extends Label

onready var mouse_controller = $"../mouse_controller"

func _process(delta):
	match mouse_controller.mode:
		0:
			self.text = "Drag"
		1: 
			self.text = "Draw paths"
