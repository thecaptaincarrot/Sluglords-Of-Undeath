extends VBoxContainer

export(String,"Always Enabled","Sea Facing") var enable_condition

export (String,"Docks","Osseorium","Rot Farm") var target
var target_building

var enabled = false 

signal build

# Called when the node enters the scene tree for the first time.
func _ready():
	init_to_target()
	build_out_info()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func button_disable():
	if not enabled:
		
		$ErrorMessage.show()
		$BaseBox/BuildingFuncs/BuildButton.disabled = true

func check_enabled(faction, hex):
	var cost_bool = false
	var condition_bool = false
	
	$ErrorMessage.text = ""
	$ErrorMessage.hide()
	if faction.gold >= target_building.gold_cost and faction.corpses >= target_building.corpse_cost and faction.contagion >= target_building.contagion_cost:
		cost_bool = true
	else:
		$ErrorMessage.text = "insufficient resources"
		cost_bool = false
		
	match target_building.enable_condition:
		"Always Enabled":
				condition_bool = true
		"Sea Facing":
			if not hex.check_sea_facing():
				$ErrorMessage.text = $ErrorMessage.text + "\nRequires Sea Outlet"
				condition_bool = false
			else:
				condition_bool = true
	
	if cost_bool and condition_bool:
		$BaseBox/BuildingFuncs/BuildButton.disabled = false
	else:
		$BaseBox/BuildingFuncs/BuildButton.disabled = true
		$ErrorMessage.show()
		


func init_to_target():
	print("Init_Successful")
	match target:
		"Osseorium":
			target_building = Osseorium


func build_out_info():
	$BaseBox/BuildingIcon.texture = load(target_building.icon)
	$BaseBox/BuildingInfo/NameBuilding.text = target_building.identity
	$BaseBox/BuildingInfo/BuildingDesc.text = target_building.verbose_description + "\n \n" + target_building.short_description
	
	if target_building.gold_cost == 0:
		$BaseBox/BuildingFuncs/Costs/Gold.hide()
	$BaseBox/BuildingFuncs/Costs/Gold.text = "Gold: " + str(target_building.gold_cost)
		
	if target_building.corpse_cost == 0:
		$BaseBox/BuildingFuncs/Costs/Corpse.hide()
		
	$BaseBox/BuildingFuncs/Costs/Corpse.text = "Corpses: " + str(target_building.corpse_cost)
		
	if target_building.contagion_cost == 0:
		$BaseBox/BuildingFuncs/Costs/Contagion.hide()
	$BaseBox/BuildingFuncs/Costs/Contagion.text = "Contagion: " + str(target_building.contagion_cost)
	
	$BaseBox/BuildingFuncs/ConstructionTime.text = str(target_building.build_time) + " Turns"


func _on_BuildButton_pressed():
	emit_signal("build",target_building)
	#Subtract Resources from player faction.
	
