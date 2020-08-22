extends PanelContainer

export (PackedScene) var build_panel

var moused_over = false

var target_hex
var player_faction

signal deselect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func initialize_menu(hex,faction):
	player_faction = faction
	target_hex = hex
	
	hex.update_production()
	#Production
	$MarginContainer/VBoxContainer/HBoxContainer/HexIdentifiers/Production/Gold.text = "Gold: " + str(hex.gold_production)
	$MarginContainer/VBoxContainer/HBoxContainer/HexIdentifiers/Production/Corpses.text = "Corpses: " + str(hex.corpse_production)
	$MarginContainer/VBoxContainer/HBoxContainer/HexIdentifiers/Production/Contagion.text = "Contagion: " + str(hex.contagion_production)
	$MarginContainer/VBoxContainer/NameAndLocation/IslandName.text = "Island of " + hex.island.name
	$MarginContainer/VBoxContainer/NameAndLocation/HexLocation.text = "Hex (" + str(hex.axial.x) + "," + str(hex.axial.y) + ")"
	#***Placeholder for features since they're non existant***
	$MarginContainer/VBoxContainer/HBoxContainer/HexIdentifiers/Feature.hide()
	#Building operations
	if hex.building == null:
		$MarginContainer/VBoxContainer/HBoxContainer/BuildingInfo/VBoxContainer/BuildingName.text = "*N O N E*"
		$MarginContainer/VBoxContainer/HBoxContainer/BuildingInfo/VBoxContainer/BuildingDescription.hide()
	else:
		$MarginContainer/VBoxContainer/HBoxContainer/BuildingInfo/VBoxContainer/BuildingDescription.show()
		if hex.building_turns_left > 0:
			$MarginContainer/VBoxContainer/HBoxContainer/BuildingInfo/VBoxContainer/BuildingName.text = hex.building.identity
			$MarginContainer/VBoxContainer/HBoxContainer/BuildingInfo/VBoxContainer/BuildingDescription.text = "In Progress:\nTurns left: " + str(hex.building_turns_left)
		else:
			$MarginContainer/VBoxContainer/HBoxContainer/BuildingInfo/VBoxContainer/BuildingName.text = hex.building.identity
			$MarginContainer/VBoxContainer/HBoxContainer/BuildingInfo/VBoxContainer/BuildingDescription.text = hex.building.description
			


func _on_BuildButton_pressed():
	var new_window = build_panel.instance()
	new_window.rect_position.x = rect_size.x
	new_window.rect_size.y = rect_size.y
	new_window.connect("mouse_entered",get_parent(),"_on_TabContainer_mouse_entered")
	new_window.connect("mouse_exited",get_parent(),"_on_TabContainer_mouse_exited")
	new_window.check_enabled(player_faction, target_hex)
	get_parent().get_parent().add_child(new_window)
