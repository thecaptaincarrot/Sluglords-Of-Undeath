extends "res://Undead/undead_blank.gd"


func _ready():
	identity = "Skeleton"
	description = "With the superfluous flesh stripped away by industrious insects, the remaining bones take much more readily to necromantic enchantments creating stronger thralls."

	icon = "res://Undead/images/Skeleton.png"
	#The number in the horde, which will reduce as it takes damage
	base_quantity = 5
	
	#basic stats
	attack = 2 #1 attack does 1 point of damage
	defense = 0 #basic ass undead has 0. unclear what defense does yet
	HP = 2 #damage spills over to others of the same troop, but not necessarily to other undead in the same army
	complexity = 2 #Affects how skilled of menial sload you need to control it
	
	recruitment_turns = 1
	
	gold_cost = 250
	corpses_cost = 5 #This should never be 0 (unless you're summoning daedra?)
	#usually equal to the troop size unless it's a big ole undead man
	contagion_cost = 0 #usually 0
	
	requires_osseorium = false #if other considerations needed, add additional below.
	
	special_abilities = null #Placeholder
	
	path = "res://Undead/Skeleton.gd"

#No process needed
