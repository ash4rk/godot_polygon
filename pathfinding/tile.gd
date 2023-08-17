extends TextureRect
class_name Tile

enum State {DEFAULT, WALL, VISITED}

var state: int = State.DEFAULT setget _set_current_state, _get_current_state


func _get_current_state():
	return state


func _set_current_state(new_value):
	state = new_value
	match state:
		State.DEFAULT:
			self.modulate = Color.white
		State.WALL:
			self.modulate = Color.red
		State.VISITED:
			self.modulate = Color.green
		State.DEFAULT:
			self.modulate = Color.white
