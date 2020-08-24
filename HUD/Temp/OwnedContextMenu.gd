extends Control

var target_hex
var target_island
var player_faction

signal state_change

onready var main_node = get_parent().get_parent() #this should be handled by signals tbh

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func initialize(hex, faction, island):
	$TabContainer/Hex.initialize_menu(hex, faction)
	$TabContainer/Island.initialize_menu(island, faction)
	
	target_hex = hex
	target_island = island
	player_faction = faction


func re_initialize():
	$TabContainer/Hex.initialize_menu(target_hex, player_faction)
	$TabContainer/Island.initialize_menu(target_island, player_faction)

func _on_TabContainer_tab_changed(tab):
	for hex in target_island.hexes:
		hex.deselect()
	
	if tab == 0:
		target_hex.select()
	elif tab == 1:
		for hex in target_island.hexes:
			hex.select()


func recruit_downwell(junk):
	$TabContainer/Island.update_queue()


func _on_AttackButton_pressed():
	emit_signal("state_change","Attacking")
