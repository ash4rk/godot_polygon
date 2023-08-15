extends Node
#  A B C D
#A 0 2 3 0
#B 2 0 2 3
#C 3 2 0 1
#D 0 3 1 0


func _ready():
	var graph = create_graph(4, 4)
	print("empty_graph: ", graph)
	
	graph[0][1] = 2
	graph[1][0] = 2
	
	graph[0][2] = 3
	graph[2][0] = 3
	
	graph[1][3] = 3
	graph[3][1] = 3
	
	graph[1][2] = 2
	graph[2][1] = 2
	
	graph[3][2] = 1
	graph[2][3] = 1
	
	print("filled_graph: ", graph)


func create_graph(width: int, height: int) -> Array:
	var matrix = []
	for x in range(width):
		matrix.append([])
		for y in range(height):
			matrix[x].append(0)
			
	return matrix

