extends TabContainer

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
	for i in range(8):
		print(i)
		var target_box = $Island/VBoxContainer/QueueBox/VBoxContainer.get_child(i)
		print(target_box)
		var target_label = target_box.get_node("QueueIdentity") #ugh
		var target_turns_label = target_box.get_node("TurnsLeft")
		
		target_label.text = ""
		target_turns_label.text = ""
	
	var queue_length = len(island.undead_queue)
	
	if queue_length > 8:
		$Island/VBoxContainer/QueueBox/VBoxContainer/Etc.show()
		queue_length = 8 #cap at 8 places
	else:
		$Island/VBoxContainer/QueueBox/VBoxContainer/Etc.hide()
		
	for i in range(queue_length):
		var target_box = $Island/VBoxContainer/QueueBox.get_child(i)
		var target_label = target_box.get_node("QueueIdentity") #ugh
		var target_turns_label = target_box.get_node("TurnsLeft")
		
		var prospective_undead = island.undead_queue[i]["type"]
		var turns_left = island.undead_queue[i]["turns"]
		
		target_label.text = prospective_undead.identity
		target_turns_label.text = str(turns_left)
		
		
		
		
		
	
