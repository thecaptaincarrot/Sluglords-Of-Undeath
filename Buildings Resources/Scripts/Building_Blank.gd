extends Node

var identity = "Name by another Name"

var verbose_description = "longer description of any ancillary effects"
var short_description = "Just the resource bonuses"

var description = "a combination of verbose_description and Short_description"

var enable_condition = "Always"
#Possible values:

var build_time = 999 #number of turns to construct with no modifiers

var gold_cost = 9999
var corpse_cost = 9999
var contagion_cost = 9999

var gold_production = 9999
var corpse_production = 9999
var contagion_production = 9999

var icon = "res://Buildings Resources/Osseorium_Placeholder_Icon.png" #Path to 64x64 icon
var texture = "res://Buildings Resources/Osseorium_Placeholder.png" #path to 128x128 icon
var in_progress_texture = "" #path to 128x128 halfway icon



# Called when the node enters the scene tree for the first time.
func _ready():
	identity = ""
	
	verbose_description = ""
	short_description = ""
	description = verbose_description + short_description
	
	enable_condition = ""
	
	build_time = 999
	
	gold_cost = 9999
	corpse_cost = 9999
	contagion_cost = 9999
	
	gold_production = 9999
	corpse_production = 9999
	contagion_production = 9999
	
	icon = "res://Buildings Resources/Osseorium_Placeholder_Icon.png" #Path to 64x64 icon
	texture = "res://Buildings Resources/Osseorium_Placeholder.png" #path to 128x128 icon
	in_progress_texture = "" #path to 128x128 halfway icon


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
