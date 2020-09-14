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
	else:
		$Hex/VBoxContainer/BuildingName.text = hex.building.identity
		$Hex/VBoxContainer/VerboseDescription.text = hex.building.verbose_description
		$Hex/ShortDescription.text = hex.building.short_description
		if hex.building_turns_left > 0:
			$Hex/ShortDescription.hide()
		else:
			$Hex/ShortDescription.show()
	pass


func refresh_island_menu():
	pass
