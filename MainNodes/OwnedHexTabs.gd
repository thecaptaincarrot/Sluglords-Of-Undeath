extends TabContainer

export (PackedScene) var QueueElement

var hex
var island

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func new_hex_selected(new_hex):
	hex = new_hex
	island = new_hex.island
	refresh_hex_menu()
	show()


func refresh_hex_menu():
	$Hex/VBoxContainer/HBoxContainer/AxialX.text = str(hex.axial.x)
	$Hex/VBoxContainer/HBoxContainer/AxialY.text = str(hex.axial.y)
	
	$Hex/VBoxContainer/HBoxContainer2/IslandName.text = island.name
	
	hex.update_production()
	$Hex/VBoxContainer/CenterContainer/HBoxContainer/VBoxContainer2/GoldNum.text = str(hex.gold_production)
	$Hex/VBoxContainer/CenterContainer/HBoxContainer/VBoxContainer2/CorpsesNum.text = str(hex.corpse_production)
	$Hex/VBoxContainer/CenterContainer/HBoxContainer/VBoxContainer2/ContagionNum.text = str(hex.contagion_production)
	
	if hex.building == null:
		$Hex/VBoxContainer/BuildingName.text = "None"
		$Hex/VBoxContainer/VerboseDescription.text = ""
		$Hex/ShortDescription.text = ""
		$Hex/BuildButton/TurnCountBox.hide()
	else:
		$Hex/VBoxContainer/BuildingName.text = hex.building.identity
		$Hex/VBoxContainer/VerboseDescription.text = hex.building.verbose_description
		$Hex/ShortDescription.text = hex.building.short_description
		if hex.building_turns_left > 0:
			$Hex/BuildButton/TurnCountBox.show()
			$Hex/BuildButton/TurnCountBox/TurnCountNum.text = str(hex.building_turns_left)
			$Hex/ShortDescription.hide()
		else:
			$Hex/BuildButton/TurnCountBox.hide()
			$Hex/ShortDescription.show()
	pass


func refresh_island_menu():
	$Island/VBoxContainer/HBoxContainer/IslandName.text = island.name
	$Island/VBoxContainer/HBoxContainer2/SizeNum.text = str(len(island.hexes))
	$Island/VBoxContainer/HBoxContainer3/OwnerName.text = island.faction_owner.name
	
	$Island/VBoxContainer/ProductionBox/production/HBoxContainer2/GoldNum.text = str(island.get_gold_production())
	$Island/VBoxContainer/ProductionBox/production/HBoxContainer2/CorpsesNum.text = str(island.get_corpses_production())
	$Island/VBoxContainer/ProductionBox/production/HBoxContainer2/ContagionNum.text = str(island.get_contagion_production())
	
	#update queue
	for N in $Island/QueueScrollBox/QueueVBox.get_children():
		N.queue_free()
		
	var i = 1
	
	for undead in island.undead_queue:
		var undead_name = undead["type"].identity
		var turns = undead["turns"]
		
		var new_element = QueueElement.instance()
		new_element.update_info(i, undead_name, turns)
		$Island/QueueScrollBox/QueueVBox.add_child(new_element)
		
		i = i + 1
