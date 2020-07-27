extends Node

var gold_production = 0
var corpse_production = 0
var contagion_production = 0

var gold
var corpses
var contagion

var color = Color(1.0,0,1.0,1.0)

var avatar = {"Eyes" : 0, "Mouth" : 0, "Hat" : 0, "Clothes" : 0}
var sloadname = "N'gasta"

var is_player = false

var territory_islands = []
var territory_hexes = []

# Called when the node enters the scene tree for the first time.
func _ready():
	name = sloadname


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func initialize_new_faction():
	gold = 500
	corpses = 0
	contagion = 0


func clear_faction():
	gold = 500
	corpses = 0
	contagion = 0
	
	for island in territory_islands:
		island.clear_owner()
	
	territory_islands.clear()
	territory_hexes.clear()

func take_ownership(island):
	island.faction_owner = self
	territory_islands.append(island)
	
	var hexes = island.hexes
	for hex in hexes:
		hex.faction_owner = self
		territory_hexes.append(hex)
		hex.get_node("DrawHex").color = color
		
		
	print(sloadname + " took control of " + island.name + " island.")


func update_production():
	
	for hex in territory_hexes:
		hex.update_production()


func collect_production():
	for hex in territory_hexes:
		gold += hex.gold_production
		corpses += hex.corpse_production
		contagion += hex.contagion_production
		print("Collected gold in an amount of: " + str(gold))


func end_of_turn():
	#check timed events
	#generate an event maybe
	#move armies and resolve battles
	print("Turn Ended Successfully")
	update_production()
	collect_production()
	#construct buildings

