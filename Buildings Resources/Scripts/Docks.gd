extends "res://Buildings Resources/Scripts/Building_Blank.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	identity = "Docks"
	
	verbose_description = "A launching point for attacks to other islands"
	short_description = "+50 gold"
	description = verbose_description + "\n\n" + short_description
	
	enable_condition = "Sea Facing"
	
	build_time = 3
	
	gold_cost = 500
	corpse_cost = 0
	contagion_cost = 0
	
	gold_production = 50
	corpse_production = 0
	contagion_production = 0
	
	icon = "res://Buildings Resources/DocksLol_Icon.png" #Path to 64x64 icon
	texture = "res://Buildings Resources/DocksLol.png" #path to 128x128 icon
	in_progress_texture = "res://Buildings Resources/DocksLol.png" #path to 128x128 halfway icon


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
