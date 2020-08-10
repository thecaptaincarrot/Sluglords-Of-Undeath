extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func initialize_menu(island, faction):
	$MarginContainer/CenterContainer/HBoxContainer/BasicInformation/IslandName.text = "Island of " + island.name
	$MarginContainer/CenterContainer/HBoxContainer/BasicInformation/IslandSize.text = "Size: " + str(len(island.hexes))
	
