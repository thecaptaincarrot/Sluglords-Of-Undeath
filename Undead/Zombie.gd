extends "res://Undead/undead_blank.gd"

var current_health 

var quantity

func _ready():
	identity = "Zombie"
	description = "A sea bloated corpse found on Thrassian shores and haphazardly animated. While not particularly useful, it is at least ubiquitous and cheap"

	icon = "res://Undead/images/Zombie.png"
	#The number in the horde, which will reduce as it takes damage
	base_quantity = 5
	quantity = base_quantity
	
	#basic stats
	attack = 1 #1 attack does 1 point of damage
	defense = 0 #basic ass undead has 0. unclear what defense does yet
	HP = 1 #damage spills over to others of the same troop, but not necessarily to other undead in the same army
	current_health = HP
	
	complexity = 1 #Affects how skilled of menial sload you need to control it
	
	recruitment_turns = 1
	
	gold_cost = 50
	corpses_cost = 5 #This should never be 0 (unless you're summoning daedra?)
	#usually equal to the troop size unless it's a big ole undead man
	contagion_cost = 0 #usually 0
	
	requires_osseorium = false #if other considerations needed, add additional below.
	
	special_abilities = null #Placeholder
	
	path = "res://Undead/Zombie.gd"

#No process needed
