extends Node2D

var start_island #the island that this attack is launching from. Must be set when instanced
var target_island
var target_hex

var faction #the faction that owns this attack. Must be set when instanced

var is_player = false #if not player owned, don't go through the whole rigamarole

var walking = false

#Do these need to be global variables?
var frontier = []
var reached =[]
var came_from = {}



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	draw_polyline ($Path2D.curve.get_baked_points(), Color.aquamarine, 5, true)


func send_attack(): #commits the attack. This is the final step to the process.
	pass

#3 step process
#1. create_pathing()
#2. add_undead()
#3. send_attack()

#These three functions are called by their parents individually.

func create_pathing(start, target): 
	#this function will go through the process of figuring out the attack.
	#if it is not coming from a player faction, then the attack is sent without
	#further ado.
	#if it is from the player faction, then the attack is only sent via
	#signal from the player, or it is scrapped altogether.
	#The player must also be able to re draw the path to a new island in a 
	#lightweight way. (unless completely scrapping the attack is quick)
	start_island = start
	target_island = target
	
	#1. create the path from the elements given and set it to the path 2D
	var path = find_shortest_path() #an array of **hexes**
	
	$AttackPath.curve.clear_points()
	
	for hex in path:
		$AttackPath.curve.add_point(hex.position)
	
	pass


func add_undead(rank,undead_array,sload = null):
	#Rank 0 is the horde, and cannot take a sload.
	#Complexity decisions will have to be done elsewhere
	match rank:
		0:
			if sload != null:
				print("***ERROR: TRIED TO ADD A MENIAL SLOAD IN HORDE FOR FACTION " + faction.name + "***")
			for undead in undead_array:
				undead.get_parent().remove_child(undead)
				$Horde/Undead.add_child(undead)
		1:
			if sload == null:
				print("***ERROR: FAILED TO ADD MENIAL SLOAD IN RANK 1 FOR FACTION " + faction.name + "***")
			else:
				sload.get_parent().remove_child(sload)
				$Rank1/Sload.add_child(sload)
			for undead in undead_array:
				undead.get_parent().remove_child(undead)
				$Rank1/Undead.add_child(undead)
		2:
			if sload == null:
				print("***ERROR: FAILED TO ADD MENIAL SLOAD IN RANK 2 FOR FACTION " + faction.name + "***")
			else:
				sload.get_parent().remove_child(sload)
				$Rank2/Sload.add_child(sload)
			for undead in undead_array:
				undead.get_parent().remove_child(undead)
				$Rank2/Undead.add_child(undead)
		3:
			if sload == null:
				print("***ERROR: FAILED TO ADD MENIAL SLOAD IN RANK 3 FOR FACTION " + faction.name + "***")
			else:
				sload.get_parent().remove_child(sload)
				$Rank3/Sload.add_child(sload)
			for undead in undead_array:
				undead.get_parent().remove_child(undead)
				$Rank3/Undead.add_child(undead)
	pass


func find_shortest_path():
	#must find the shorted path between two islands. The ending point can be any
	#point on the island
	
	#The starting point is either a dock, or any set hex. Attacks that start from
	#docks move an upgradeable 2 hexes per turn. Otherwise, the undead can walk
	#across the ocean floor at a rate of 1 hex per turn.
	
	#After the shortest path is found, set the path2D to that path and draw it
	#with confirmation menu
	
	var dock_hexes = []
	var non_dock_hexes = []
	
	var test_path
	var final_path
	
	var path_length = 999 #arbitrarily long
	#1. separate out the dock and non-dock hexes
	for hex in start_island.get_hexes():
		if hex.building == Docks:
			dock_hexes.append(hex)
		else:
			non_dock_hexes.append(hex)
	
	for hex in dock_hexes:
		test_path = find_path(hex,target_hex)
		var dock_path_length = round(len(test_path) / 2) #2 represents the amount of hexes that a boat can travel in one turn
		if dock_path_length < path_length:
			final_path = test_path
			walking = false
	
	for hex in non_dock_hexes:
		test_path = find_path(hex,target_hex)
		var dock_path_length = len(test_path) #undead will never walk more than one hex per turn
		if dock_path_length < path_length:
			final_path = test_path
			walking = true
	
	return final_path


func calculate_paths(start):
	#calculates paths to ALL hexes
	frontier.push_back(start) #START IS A HEX
	came_from[start] = null
	while not frontier.empty():
		var current = frontier.pop_front()
		for next in current.get_neighbors():
			if not came_from.has(next):
				if next.type != next.LAND:
					frontier.push_back(next)
				came_from[next] = current
	


func find_path(start, goal): #start is a hex, goal is an island
	var current
	var path = []
	
	calculate_paths(start) #calculates all possible paths to all possible hexes
	
	var new_path = []
	
	var shortest_path = 999
	for hex in goal.hexes:
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


func empty_undead():
	#Not sure how Sload will be referenced, but here we are.
	for undead in $Horde/Undead.get_children():
		undead.get_parent().remove_child(undead)
		start_island.get_node("Undead").add_child(undead)
	
	for undead in $Rank1/Undead.get_children():
		undead.get_parent().remove_child(undead)
		start_island.get_node("Undead").add_child(undead)
	
	for undead in $Rank2/Undead.get_children():
		undead.get_parent().remove_child(undead)
		start_island.get_node("Undead").add_child(undead)
	
	for undead in $Rank3/Undead.get_children():
		undead.get_parent().remove_child(undead)
		start_island.get_node("Undead").add_child(undead)
	









