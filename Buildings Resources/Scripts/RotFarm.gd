extends "res://Buildings Resources/Scripts/Building_Blank.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	identity = "Rot Farm"
	
	verbose_description = "Produces sellable efluvia for gold"
	short_description = "+25 gold\n+1 contagion"
	description = verbose_description + "\n\n" + short_description
	
	enable_condition = "Always Enabled"
	
	build_time = 3
	
	gold_cost = 200
	corpse_cost = 0
	contagion_cost = 0
	
	gold_production = 25
	corpse_production = 0
	contagion_production = 1
	
	icon = "res://Buildings Resources/RotFarm_Icon.png" #Path to 64x64 icon
	texture = "res://Buildings Resources/RotFarm.png" #path to 128x128 icon
	in_progress_texture = "res://Buildings Resources/RotFarm.png" #path to 128x128 halfway icon
