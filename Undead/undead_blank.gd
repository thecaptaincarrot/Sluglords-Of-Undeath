extends Node
#The undead blank does not have any functions since that would alter the definition
#instead, all actual battles and shit should be handled by a separate script/node
#Which will inherit two armies and their configuration.

var identity = "Zombie"
var description = "Placeholder Description"

var icon = "res://Undead/images/Undead_Default.png"
#The number in the horde, which will reduce as it takes damage
var base_quantity = 5

#basic stats
var attack = 1 #1 attack does 1 point of damage
var defense = 0 #basic ass undead has 0. unclear what defense does yet
var HP = 1 #damage spills over to others of the same troop, but not necessarily to other undead in the same army
var complexity = 1 #Affects how skilled of menial sload you need to control it

var recruitment_turns = 1  #Self Explanatory I hope

var gold_cost = 50
var corpses_cost = 5 #This should never be 0 (unless you're summoning daedra?)
#usually equal to the troop size unless it's a big ole undead man
var contagion_cost = 0 #usually 0

var requires_osseorium = false #if other considerations needed, add additional below.

var special_abilities = null #Placeholder

var path = "res://Undead/undead_blank.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
