extends "res://Buildings Resources/Scripts/Building_Blank.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	identity = "Osseorium"
	
	verbose_description = "Allows the recruitment of more advanced undead"
	short_description = "+3 corpses \n+1 recruitment capacity"
	description = verbose_description + "\n\n" + short_description
	
	enable_condition = "Always Enabled"
	
	build_time = 3
	
	gold_cost = 1000
	corpse_cost = 10
	contagion_cost = 0
	
	gold_production = 0
	corpse_production = 2
	contagion_production = 0
	
	icon = "res://Buildings Resources/Osseorium_Placeholder_Icon.png" #Path to 64x64 icon
	texture = "res://Buildings Resources/Osseorium_Placeholder.png" #path to 128x128 icon
	in_progress_texture = "res://Buildings Resources/Osseorium_Placeholder.png" #path to 128x128 halfway icon


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
