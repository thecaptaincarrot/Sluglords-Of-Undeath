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
signal sea_hex_clicked
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#Pregame Initializations


func _on_Hex_hex_clicked(hex):
	if hex.type == hex.SEA:
		emit_signal("sea_hex_clicked",hex)
		return
	
	if hex.faction_owner == player_faction:
		emit_signal("owned_hex_clicked",hex)
	elif hex.faction_owner == null:
		emit_signal("unowned_hex_clicked",hex)


func _on_NextTurnButton_pressed():
	#This is an example of the top level of a game scene...
	#Rather than using signal ticks, it's better to do direct function calls
	#To preserve the order that it needs to be done in

	#All objects (armies, buildings, hexes, etc) should have a reference in
	#the faction node. as such, calling all necesary End Turn shit should 
	#be relatively easy. At least, it should be built that way.
	turn += 1
	#Factions go first, collect income, etc
	for faction in $Factions.get_children():
		print(faction.name)
		faction.end_of_turn()
		
	#update other shit
	for N in $Map/Hex.get_children():
		if N.has_method("end_of_turn"):
			N.end_of_turn()
			
	for N in $Map/Island.get_children():
		if N.has_method("end_of_turn"):
			N.end_of_turn()
