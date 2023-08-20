extends CanvasLayer

var town_list = []

func _ready():
  _connect_towns_to_signals()

func _connect_towns_to_signals():
	for town in $sockets.get_children():
		town.connect('pressed', self, '_on_town_pressed', [town])
		town.connect('released', self, '_on_town_released', [town])

#func _on_town_pressed(town):
#	if town_list.empty() or town.color == town.front().color:
#		town_list.append(town)

#func _on_hex_released(town):
#	if mouse_is_on(town):
#		town_list = []
		
