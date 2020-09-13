extends Node2D

#scene variables
export (PackedScene) var Faction

#Easy Node Access
onready var Map = $Map
onready var Islands = $Map/Island
onready var Hexes = $Map/Hex

onready var HUD = $HUDcanvas/PermanentHUD
onready var ContextWindow = $HUDcanvas/ContextMenus

var player_faction

#enums for game states
enum {DEFAULT, ATTACKING}
var state = DEFAULT

var turn = 1

signal turn_over #I don't think we can send turn over like this since all players need to go sequentially... Unless
#The switching for the type of hex happens at this top level.
signal owned_hex_clicked
signal unowned_hex_clicked
signal rival_hex_clicked
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pregenerate_new_player_faction()
	update_HUD()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Pregame Initializations
func pregenerate_new_player_faction():
	player_faction = Faction.instance()
	player_faction.is_player = true
	player_faction.initialize_new_faction()
	
	$Factions.add_child(player_faction)
	
	var random_deck = []
	
	for island in Islands.get_children():
		if island.name == "The Pillar of Thras" or island.identity == "Hex":
			pass
		else:
			random_deck.append(island)
	randomize()
	random_deck.shuffle()
	var chosen_island = random_deck.front()
	
	player_faction.take_ownership(chosen_island)
	
	var possible_hexes = chosen_island.get_hexes()
	possible_hexes.shuffle()
	
	var chosen_hex = possible_hexes.front()
	
	chosen_hex.insta_build(Osseorium)


#Updates
func update_HUD():
	HUD.update_resources(player_faction.gold,player_faction.corpses,player_faction.contagion)


func _on_Hex_hex_clicked(hex):
	print(hex)
	print(hex.z_index)
	if hex.faction_owner == player_faction:
		emit_signal("owned_hex_clicked",hex)
