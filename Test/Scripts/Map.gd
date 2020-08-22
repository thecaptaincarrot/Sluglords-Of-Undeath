extends Node2D

export (PackedScene) var Hex
export (PackedScene) var Island

export var size = 32

export var map_size = 9
export var min_island_size = 8
export var max_island_size = 12
export var distance_between_islands = 1

var islands = []

var neighbors = [Vector2(0,-1), Vector2(1,-1), Vector2(-1,0), Vector2(1,0), Vector2(-1,1), Vector2(0,1)]

var hex_map = {} # need to initialize
var land_tiles = {}
var center_hex 

# Called when the node enters the scene tree for the first time.
func _ready():
	#initialize hex_map with empty hexes
	clear_map()
	#All tiles are now sea tiles. Tiles that are not NULL are viable 



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func build_map_old():

#	#1. an island is between min and max in size
#	#2. an island cannot touch another island
#	#3. an island cannot be in or touch the center 3 tiles
#	#4. an island must be within the 15 tiles
#
#	#fill array with elements from the hex map, based not on their position
#	#but only eligibility.
#	var eligible_tiles = hex_map.duplicate(true)
#	#Clear the center tiles as eligible
#	for _i in range(0,3):
#		for q in range(-(len(eligible_tiles) - 1) / 2, 1 + (len(eligible_tiles) - 1) / 2) :
#			for r in range(-(len(eligible_tiles[q]) - 1) / 2, 1 + (len(eligible_tiles[q]) - 1) / 2):
#				if eligible_tiles[q][r] != null:
#					if eligible_tiles[q][r].distance_to_hex(center_hex) <= distance_between_islands + 1:
#						if eligible_tiles[q][r].distance_to_hex(center_hex) <= 1:
#							hex_map[q][r].type = hex_map[q][r].LAND
#						eligible_tiles[q][r] = null
#	#edge is not available
#	for q in range(-(len(eligible_tiles) - 1) / 2, 1 + (len(eligible_tiles) - 1) / 2) :
#		for r in range(-(len(eligible_tiles[q]) - 1) / 2, 1 + (len(eligible_tiles[q]) - 1) / 2):
#			if eligible_tiles[q][r] != null:
#				if eligible_tiles[q][r].distance_to_hex(center_hex) == map_size:
#					eligible_tiles[q][r] = null
#	#~~Populating islands~~
#	var map_in_progress = true
#
#	while map_in_progress:
#		var new_island = Island.instance()
#		#1. Build array of all possible Hexes for an initial hex tile and select one.
#		#	THIS IS NOT A CLEANUP OF ELIGIBLE HEXES, ONLY ADDING INTO HEX DECK
#		var hex_deck = []
#		for q in range(-(len(eligible_tiles) - 1) / 2, 1 + (len(eligible_tiles) - 1) / 2) :
#			for r in range(-(len(eligible_tiles[q]) - 1) / 2, 1 + (len(eligible_tiles[q]) - 1) / 2):
#				if eligible_tiles[q][r] != null:
#					hex_deck.append(eligible_tiles[q][r])
#		if len(hex_deck) < min_island_size:
#			map_in_progress = false
#			break
#		#2. choose a random island size from the min and max.
#		#	this is the maximum size of the island, but it may end early
#		randomize()
#		var island_size = (randi() % (int(max_island_size) - int(min_island_size))) + min_island_size - 1
#
#		#2.1. add random hex to island
#		var deck_size = len(hex_deck)
#		var card_pick = randi() % deck_size
#		var new_island_array = []
#		new_island_array.append(hex_deck[card_pick])
#		#NOW THAT AN ISLAND IS INITIALIZED, CREATE SUB LOOP
#		var island_in_progress = true
#		while island_in_progress:
#			#3. Create an array of possible next tiles from the following criteria:
#			#		a. It neighbors an island tile
#			#		b. It is not already part of the island ~should be removed from eligible
#			#		c. It does not neighbor any other land tiles ~ should be removed from eligible
#			#clear hex_deck
#			hex_deck.clear()
#			#array of neighbors
#			#if the size of hex_deck is larger than 5 x the number of tiles then you can stop searching 
#			for q in range(-(len(eligible_tiles) - 1) / 2, 1 + (len(eligible_tiles) - 1) / 2) :
#				for r in range(-(len(eligible_tiles[q]) - 1) / 2, 1 + (len(eligible_tiles[q]) - 1) / 2):
#					if len(new_island_array) == 1 :
#						if eligible_tiles[q][r] != null: #tile is eligible
#							if new_island_array[0].distance_to_hex(eligible_tiles[q][r]) == 1 : #Adjacent tile
#								if new_island_array.find(eligible_tiles[q][r]) == -1:#duplicate check
#									hex_deck.append(eligible_tiles[q][r])
#					else:
#						for i in range(0,len(new_island_array) - 1):
#							if eligible_tiles[q][r] != null: #tile is eligible
#								if new_island_array[i].distance_to_hex(eligible_tiles[q][r]) == 1 : #Adjacent tile
#									if new_island_array.find(eligible_tiles[q][r]) == -1:#duplicate check
#										hex_deck.append(eligible_tiles[q][r])
#				if len(hex_deck) >= 5 * len(new_island_array):
#					break
#			#pick a new card
#			if len(hex_deck) < 1 :
#				island_in_progress = false
#				break #get out if no eligible tiles
#
#			#4. add a random tile from that array to the island, then check size. If size has not been reached, continue from 3
#			#	until the island size has been reached
#			deck_size = len(hex_deck)
#			card_pick = randi() % deck_size
#			new_island_array.append(hex_deck[card_pick])
#			if len(new_island_array) >= island_size:
#				island_in_progress = false
#				break
#		#6. check if the island is larger than the minimum island size.
#		if len(new_island_array) >= min_island_size:
#			#If yes, commit island. in this case, set it all to land and remove adjacent (<= 1) tiles from eligible tiles
#			for i in range(0,len(new_island_array)):
#				var shit = new_island_array[i].cube
#				for q in range(-(len(eligible_tiles) - 1) / 2, 1 + (len(eligible_tiles) - 1) / 2) :
#					for r in range(-(len(eligible_tiles[q]) - 1) / 2, 1 + (len(eligible_tiles[q]) - 1) / 2):
#						if eligible_tiles[q][r] != null:
#							if eligible_tiles[q][r].distance_to_hex(new_island_array[i]) <= distance_between_islands:
#								eligible_tiles[q][r] = null
#			#6.1. turn all hexes to land, this is a temporary measure
#			for i in range(0,len(new_island_array)):
#				for q in range(-(len(hex_map) - 1) / 2, 1 + (len(hex_map) - 1) / 2) :
#					for r in range(-(len(hex_map[q]) - 1) / 2, 1 + (len(hex_map[q]) - 1) / 2):
#						if hex_map[q][r] != null:
#							var distance = hex_map[q][r].distance_to_hex(new_island_array[i])
#							if distance < 1.0:
#								hex_map[q][r].type = hex_map[q][r].LAND
#		else:
#			#corner case if island array is size 1
#			if len(new_island_array) == 1:
#				for q in range(-(len(eligible_tiles) - 1) / 2, 1 + (len(eligible_tiles) - 1) / 2) :
#					for r in range(-(len(eligible_tiles[q]) - 1) / 2, 1 + (len(eligible_tiles[q]) - 1) / 2):
#						if eligible_tiles[q][r] != null:
#							if eligible_tiles[q][r].distance_to_hex(new_island_array[0]) < 1:
#								eligible_tiles[q][r] = null
#			#If no, all hexes in the island are removed from the possible hexes list, but neighbors are not.
#			for i in range(0,len(new_island_array) - 1):
#				for q in range(-(len(eligible_tiles) - 1) / 2, 1 + (len(eligible_tiles) - 1) / 2) :
#					for r in range(-(len(eligible_tiles[q]) - 1) / 2, 1 + (len(eligible_tiles[q]) - 1) / 2):
#						if eligible_tiles[q][r] != null:
#							if eligible_tiles[q][r].distance_to_hex(new_island_array[i]) < 1:
#								eligible_tiles[q][r] = null
#
#
#		#7. repeat until there are no more eligible tiles then break.
#		#Commiting islands means to remove all adjacent tiles as being eligible
	pass


func build_map_new():
	#1. an island is between min and max in size
	#2. an island cannot touch another island
	#3. an island cannot be in or touch the center 3 tiles
	#4. an island must be within the 15 tiles
	#fill array with elements from the hex map, based not on their position
	#but only eligibility.
	var eligible_tiles = hex_map.duplicate(true)
	#Clear the center tiles as eligible
	for _i in range(0,3):
		for q in range(-(len(eligible_tiles) - 1) / 2, 1 + (len(eligible_tiles) - 1) / 2) :
			for r in range(-(len(eligible_tiles[q]) - 1) / 2, 1 + (len(eligible_tiles[q]) - 1) / 2):
				if eligible_tiles[q][r] != null:
					if eligible_tiles[q][r].distance_to_hex(center_hex) <= distance_between_islands + 1:
						if eligible_tiles[q][r].distance_to_hex(center_hex) < 1:
							var new_island = Island.instance()
							new_island.hexes.append(hex_map[q][r])
							hex_map[q][r].type = hex_map[q][r].PILLAR
							new_island.init_pillar()
							$Island.add_child(new_island)
							islands.append(new_island)
						eligible_tiles[q][r] = null
	#edge is not available
	for q in range(-(len(eligible_tiles) - 1) / 2, 1 + (len(eligible_tiles) - 1) / 2) :
		for r in range(-(len(eligible_tiles[q]) - 1) / 2, 1 + (len(eligible_tiles[q]) - 1) / 2):
			if eligible_tiles[q][r] != null:
				if eligible_tiles[q][r].distance_to_hex(center_hex) == map_size:
					eligible_tiles[q][r] = null
	#~~Populating islands~~
	var map_in_progress = true

	while map_in_progress:
		var new_island = Island.instance()
		#1. Build array of all possible Hexes for an initial hex tile and select one.
		#	THIS IS NOT A CLEANUP OF ELIGIBLE HEXES, ONLY ADDING INTO HEX DECK
		#Cannot
		var hex_deck = []
		for q in range(-(len(eligible_tiles) - 1) / 2, 1 + (len(eligible_tiles) - 1) / 2) :
			for r in range(-(len(eligible_tiles[q]) - 1) / 2, 1 + (len(eligible_tiles[q]) - 1) / 2):
				if eligible_tiles[q][r] != null:
					hex_deck.append(eligible_tiles[q][r])
		if len(hex_deck) < min_island_size:
			#How can I make an island if there's not enough shit to make one
			map_in_progress = false
			break
		#2. choose a random island size from the min and max.
		#	this is the maximum size of the island, but it may end early
		randomize()
		var island_size = (randi() % (int(max_island_size) - int(min_island_size - 1))) + min_island_size
		#2.1. add random hex to island
		var deck_size = len(hex_deck)
		var card_pick = randi() % deck_size
		var new_island_array = []
		new_island_array.append(hex_deck[card_pick])
		#NOW THAT AN ISLAND IS INITIALIZED, CREATE SUB LOOP
		var island_in_progress = true
		while island_in_progress:
			#3. Create an array of possible next tiles from the following criteria:
			#		a. It neighbors an island tile
			#		b. It is not already part of the island ~should be removed from eligible
			#		c. It does not neighbor any other land tiles ~ should be removed from eligible
			#clear hex_deck
			hex_deck.clear()
			#array of neighbors
			#if the size of hex_deck is larger than 5 x the number of tiles then you can stop searching 
			for hex in new_island_array:
				var neighboring_hexes = get_neighbors(hex)
				for neighbor in neighboring_hexes:
					if neighbor in new_island_array:#Not already in array
						pass
					else:
						var x = int(neighbor.axial.x)
						var y = int(neighbor.axial.y)
						
						if eligible_tiles[x][y] != null: #is eligible
							hex_deck.append(eligible_tiles[x][y])

			#pick a new card
			if len(hex_deck) < 1 : #Nothing to pick, no eligible neighbors
				island_in_progress = false
				break #get out if no eligible tiles

			#4. add a random tile from that array to the island, then check size. If size has not been reached, continue from 3
			#	until the island size has been reached
			deck_size = len(hex_deck)
			card_pick = randi() % deck_size
			new_island_array.append(hex_deck[card_pick])
			if len(new_island_array) >= island_size: #island completed
				island_in_progress = false
				break
		#6. check if the island is larger than the minimum island size.
		if len(new_island_array) >= min_island_size:
			#If yes, commit island. in this case, set it all to land and remove adjacent (<= 1) tiles from eligible tiles
			new_island.hexes = new_island_array
			new_island.init_island()
			$Island.add_child(new_island)
			islands.append(new_island)
			for hex in new_island_array:
				hex.island = new_island
				
			
			#There isn't a real way to reduce this since distance between islands is settable
			if distance_between_islands > 1: #No need to if getting neighbors will do
				for i in range(0,len(new_island_array)):
					for q in range(-(len(eligible_tiles) - 1) / 2, 1 + (len(eligible_tiles) - 1) / 2) :
						for r in range(-(len(eligible_tiles[q]) - 1) / 2, 1 + (len(eligible_tiles[q]) - 1) / 2):
							if eligible_tiles[q][r] != null:
								if eligible_tiles[q][r].distance_to_hex(new_island_array[i]) <= distance_between_islands:
									eligible_tiles[q][r] = null
			#6.1. turn all hexes to land, this is a temporary measure
			for hex in new_island_array:
				var x = int(hex.axial.x)
				var y = int(hex.axial.y)
				eligible_tiles[x][y] = null
				var neighboring_hexes = get_neighbors(hex)
				for neighbor in neighboring_hexes:
					if (neighbor in new_island_array) == false:
						var q = int(neighbor.axial.x)
						var r = int(neighbor.axial.y)
						eligible_tiles[q][r] = null
				hex_map[x][y].type = hex_map[x][y].LAND
		#If no, all hexes in the island are removed from the possible hexes list, but neighbors are not.
		else:
			for hex in new_island_array:
				var x = int(hex.axial.x)
				var y = int(hex.axial.y)
				eligible_tiles[x][y] = null
		#7. repeat until there are no more eligible tiles then break.
		#Commiting islands means to remove all adjacent tiles as being eligible

func clear_map():
	hex_map.clear()
	
	for island in islands:
		island.clear_owner()
	islands.clear()
	
	for N in $Hex.get_children():
		N.queue_free()

	for N in $Island.get_children():
		N.queue_free()

	for q in range(map_size * -1, map_size + 1):
		var new_dict = {}
		for r in range(map_size * -1, map_size + 1):
			var new_hex = Hex.instance()
			new_hex.axial.x = q
			new_hex.axial.y = r
			new_hex.axial_to_cube()
			new_hex.size = size - 2 #pixel barrier
			new_hex.position = axial_to_pixel(q,r)
			new_dict[r] = new_hex
			$Hex.add_child(new_hex)
			new_hex.connect("clicked",get_parent(), "_on_hex_clicked")
		hex_map[q] = new_dict
		
	#center point is 0,0 don't center camera dumbass
	#All tiles within map_size tiles of the point 0,0 are sea tiles, all others
	# 	are empty
	center_hex = hex_map[0][0]
	for q in range(map_size * -1, map_size + 1):
		for r in range(map_size * -1, map_size + 1):
			if hex_map[q][r].distance_to_hex(center_hex) > map_size:
				hex_map[q][r].queue_free()
				hex_map[q][r] = null
			else:
				hex_map[q][r].type = hex_map[q][r].SEA

func axial_to_pixel(q,r):
	var x  = size * (sqrt(3) * q + (sqrt(3) / 2) * r)
	var y = size * ((3.0 / 2) * r)  * .5
	return Vector2(x,y)


func get_neighbors(hex):
	var hex_neighbors = []
	
	for direction in neighbors:
		
		var new_x = hex.axial.x + direction.x
		var new_y = hex.axial.y + direction.y
		
		new_x = int(new_x)
		new_y = int(new_y)
		if new_x in hex_map:
			if new_y in hex_map[new_x] and hex_map[new_x][new_y] != null:
				hex_neighbors.append(hex_map[new_x][new_y])
	return hex_neighbors

func get_islands():
	return $Island.get_children()


