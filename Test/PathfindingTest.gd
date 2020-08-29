extends Node2D

onready var map = $Map
var turn = 0

var start = null 
var end = null

var start_color = Color(1.0,1.0,0,1.0)
var end_color = Color(1.0,0,1.0,1.0)

var PathLine

#pathfinding shenanigans
var frontier = []
var reached =[]
var came_from = {}

var pathfinding_to = "Hex"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Remap2_pressed():
	map.size = $MapTestHUDCanvas/NewMapPanel/HexSize/PixelSelect.value
	map.map_size = $MapTestHUDCanvas/NewMapPanel/MapSize/MapSizeSelect.value
	map.min_island_size = $MapTestHUDCanvas/NewMapPanel/MinIslandSize/MinIslandSelect.value
	map.max_island_size = $MapTestHUDCanvas/NewMapPanel/MaxIslandSize/MaxIslandSelect.value
	map.distance_between_islands = $MapTestHUDCanvas/NewMapPanel/IslandSeparation/SeparationSelect.value
	
	map.clear_map()
	$MapTestHUDCanvas/ResourcesPanel.player_faction = null
	
	map.build_map_new()
	#Map is built, now find a random hex on a random island and put a laboratory there


func _on_hex_clicked(hex):
	if hex.type == hex.LAND:
		if hex == start:
			if end != null:
				end.type = end.LAND
			if start != null:
				start.type = start.LAND
				
			end = null
			start = null
		elif hex == end:
			hex.type = hex.LAND 
			end = null
		elif start != null:
			if end != null:
				end.type = end.LAND
			end = hex
			hex.color = end_color
			var new_path = find_path(end)
			draw_new_path(new_path)
		else:
			start = hex
			hex.color = start_color
			calculate_paths()


func calculate_paths():
	#Without pathing
	#With PAthing
	if start != null:
		frontier.push_back(start)
		came_from[start] = null
		while not frontier.empty():
			var current = frontier.pop_front()
			for next in current.get_neighbors():
				if not came_from.has(next):
					if next.type != next.LAND:
						frontier.push_back(next)
					came_from[next] = current
		print ("Recalculated Path")


func find_path(goal):
	var current
	var path = []
	if pathfinding_to == "Hex":
		current = goal
		while current != start:
			path.append(current)
			current = came_from[current]
	else:
		var island = goal.island
		var new_path = []
		
		var shortest_path = 999
		for hex in island.hexes:
			new_path.clear()
			if came_from.has(hex):
				current = hex
				while current != start:
					new_path.append(current)
					current = came_from[current]
				if len(new_path) < shortest_path:
					path.clear()
					path = new_path.duplicate()
					shortest_path = len(path)
					print("New Shortest path: " + str(shortest_path))
					print(path)
	print(path)
	
	path.append(start)
	return path


func draw_new_path(path):
	for child in get_children():
		if child == PathLine:
			PathLine.queue_free()
	var new_line = Line2D.new()
	for hex in path:
		new_line.add_point(hex.position)
	PathLine = new_line
	add_child(PathLine)


func _on_PathfindingType_pressed():
	if pathfinding_to == "Hex":
		pathfinding_to = "Island"
		$MapTestHUDCanvas/PathfindingType.text = "Pathfinding to Island"
	else:
		pathfinding_to = "Hex"
		$MapTestHUDCanvas/PathfindingType.text = "Pathfinding to Hex"
