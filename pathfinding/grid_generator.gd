extends Node

export var columns: int = 20
export var rows: int = 15
export var tile_scene: PackedScene

var grid := []


func _ready():
	generate_grid()
	set_tile_color(1, 5, Color(1, 1, 0))


func generate_grid():
	for x in range(columns):
		var column = []
		for y in range(rows):
			var tile = tile_scene.instance()
			add_child(tile)
			tile.rect_position = Vector2(x * tile.rect_size.x, y * tile.rect_size.y)
			column.append(tile)
		grid.append(column)


func set_tile_color(x, y, color):
	var tile = grid[x][y]
	tile.modulate = color
