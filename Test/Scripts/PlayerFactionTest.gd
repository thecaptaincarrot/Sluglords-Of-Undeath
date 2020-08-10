extends Node2D

onready var map = $Map

export (PackedScene) var Faction

#HUD
export (PackedScene) var OwnedHexMenu

var player_faction = null

var islands
var factions = []
var turn = 1

signal Tick

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RemapHUDButton_pressed():
	$MapTestHUDCanvas/NewMapPanel.show()


func _on_Remap2_pressed():
	map.size = $MapTestHUDCanvas/NewMapPanel/HexSize/PixelSelect.value
	map.map_size = $MapTestHUDCanvas/NewMapPanel/MapSize/MapSizeSelect.value
	map.min_island_size = $MapTestHUDCanvas/NewMapPanel/MinIslandSize/MinIslandSelect.value
	map.max_island_size = $MapTestHUDCanvas/NewMapPanel/MaxIslandSize/MaxIslandSelect.value
	map.distance_between_islands = $MapTestHUDCanvas/NewMapPanel/IslandSeparation/SeparationSelect.value
	
	turn = 1
	map.clear_map()
	for faction in factions:
		faction.clear_faction()
		faction.queue_free()
	factions.clear()
	$MapTestHUDCanvas/ResourcesPanel.player_faction = null
	
	map.build_map_new()
	#Map is built, now find a random hex on a random island and put a laboratory there
	
	generate_new_player_faction()
	

func generate_new_player_faction():
	player_faction = Faction.instance()
	player_faction.is_player = true
	player_faction.initialize_new_faction()
	
	factions.append(player_faction)
	$Factions.add_child(player_faction)
	$MapTestHUDCanvas/ResourcesPanel.player_faction = player_faction
	
	var random_deck = []
	
	var islands = map.islands
	
	for island in islands:
		if island.name == "The Pillar of Thras" or island.identity == "Hex":
			pass
		else:
			random_deck.append(island)
	randomize()
	print (random_deck)
	var chosen_island = random_deck[randi() % len(random_deck)]
	
	player_faction.take_ownership(chosen_island)
	
	var possible_hexes = chosen_island.get_hexes()
	
	var chosen_hex = possible_hexes[randi() % len(possible_hexes)]
	
	chosen_hex.insta_build(Osseorium)


func _on_NextTurn_pressed():
	#This is an example of the top level of a game scene...
	#Rather than using signal ticks, it's better to do direct function calls.
	#All objects (armies, buildings, hexes, etc) should have a reference in
	#the faction node. as such, calling all necesary End Turn shit should 
	#be relatively easy. At least, it should be built that way.
	turn += 1
	#Factions go first, collect income, etc
	for faction in factions:
		print(faction.name)
		faction.end_of_turn()
		
	#update other shit
	for N in $Map/Hex.get_children():
		if N.has_method("end_of_turn"):
			N.end_of_turn()
			
	for N in $Map/Island.get_children():
		if N.has_method("end_of_turn"):
			N.end_of_turn()
			


func _on_hex_clicked(hex):
	#check whether the hex is owned or not
	#if the hex is owned, create context menu
	if hex.faction_owner == player_faction and player_faction != null:
		var new_window = OwnedHexMenu.instance()
		var placement = Vector2(hex.get_global_transform_with_canvas().origin.x, hex.get_global_transform_with_canvas().origin.y)
		print(placement)
		new_window.get_node("TabContainer/Hex").initialize_menu(hex,player_faction)
		$MapTestHUDCanvas.add_child(new_window)
		new_window.rect_position = placement
		new_window.rect_position.y -= new_window.rect_size.y + 25
		new_window.get_child(0).connect("deselect",hex,"deselect")
		hex.select()
		
