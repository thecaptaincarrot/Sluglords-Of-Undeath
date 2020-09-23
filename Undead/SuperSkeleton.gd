extends "res://Undead/undead_blank.gd"


func _ready():
	identity = "Colosus"
	description = "In a stroke of mad genius, it was discovered that stacking two skeletons atop one another made them more than twice as effective..."

	icon = "res://Undead/images/Super_Skeleton.png"
	#The number in the horde, which will reduce as it takes damage
	base_quantity = 5
	
	#basic stats
	attack = 4 #1 attack does 1 point of damage
	defense = 1 #basic ass undead has 0. unclear what defense does yet
	HP = 3 #damage spills over to others of the same troop, but not necessarily to other undead in the same army
	complexity = 4 #Affects how skilled of menial sload you need to control it
	
	recruitment_turns = 3
	
	gold_cost = 1000
	corpses_cost = 10 #This should never be 0 (unless you're summoning daedra?)
	#usually equal to the troop size unless it's a big ole undead man
	contagion_cost = 0 #usually 0
	
	requires_osseorium = true #if other considerations needed, add additional below.
	
	special_abilities = null #Placeholder
	
	path = "res://Undead/SuperSkeleton.gd"

#No process needed
