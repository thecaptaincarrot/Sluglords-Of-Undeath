extends Node2D

var identity = "Island"

var island_name = ""
var hexes = []

var prefixes = ["Ta", "Go", "Cha", "Naox", "Ka", "Dra", "Tho", "Ul", "Ku", "Ahk", "Ape","Ekze"]
var midfixes = ["t", "d", "b", "x", "r", "s", "v", "st", "gx", "jt"]
var suffixes =  ["or", "", "as", "en", "auw", "as","uj", "os", "ajn"]

var faction_owner = null

var undead_array = [] #array of all undead on the island
var undead_queue = [] #array of the undead queue

var recruitment_capacity = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func init_island():
	island_name = _generate_name()
	name = island_name


func init_pillar():
	island_name = "The Pillar of Thras"
	name = island_name


func _generate_name():
	randomize()
	prefixes.shuffle()
	midfixes.shuffle()
	suffixes.shuffle()
	
	var prefix = prefixes.front()
	var midfix = midfixes.front()
	var suffix = suffixes.front()
	
	return prefix + midfix + suffix


func get_hexes():
	return hexes


func get_gold_production():
	var gold_count = 0
	for hex in hexes:
		hex.update_production()
		gold_count += hex.gold_production
	return gold_count


func get_corpse_production():
	var corpses_count = 0
	for hex in hexes:
		hex.update_production()
		corpses_count += hex.corpse_production
	return corpses_count


func get_contagion_production():
	var contagion_count = 0
	for hex in hexes:
		hex.update_production()
		contagion_count += hex.contagion_production
	return contagion_count


func clear_owner():
	faction_owner = null
	for hex in hexes:
		hex.faction_owner = null


func axial_to_pixel(q,r,size):
	var x  = size * (sqrt(3) * q + (sqrt(3) / 2) * r)
	var y = size * ((3.0 / 2) * r)
	return Vector2(x,y)


func update_recruitment_capacity():
	#just iterate through buildings and hexes looking for osseoriums
	#or any other buildings that arbitrarily increase recruitment capacity
	var temp_recruitment = 2
	for hex in hexes:
		if hex.building != null:
			if hex.building.identity == "Osseorium":
				temp_recruitment += 1
	
	recruitment_capacity = temp_recruitment


func end_of_turn():
	tick_undead_queue()


func tick_undead_queue():
	update_recruitment_capacity()
	print(undead_queue)
	for i in range(0,recruitment_capacity):
		if i < len(undead_queue):
			undead_queue[i]["turns"] -= 1
	
	var triple_check = true
	while triple_check:
		for queued in undead_queue:
			print(queued)
			if queued["turns"] <= 0:
				add_undead(queued["type"])
				undead_queue.erase(queued)
		triple_check = false
		for queued in undead_queue:
			if queued["turns"] <= 0:
				triple_check = true


func add_to_queue(undead):
	var turns = undead.recruitment_turns
	undead_queue.push_back({"turns" : turns, "type" : undead})
	print(undead_queue)


func add_undead(undead):
	#this needs its own function so I can call it from outside
	var new_undead = Node.new()
	print(undead)
	new_undead.set_script(load(undead.path))
	$Undead.add_child(new_undead)


func get_undead():
	var undead_array = []
	for undead in $Undead.get_children():
		undead_array.append(undead)
	
	print(undead_array)
	return undead_array
