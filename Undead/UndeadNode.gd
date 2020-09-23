extends Node2D

export (PackedScene) var SquadNode

onready var undead = load("res://Undead/undead_blank.gd") setget change_undead

var squadsize
var complexity
var gold_cost

var identity = "ERROR"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func change_undead(undead):
	pass
	#clear undead
	if get_child_count() > 0:
		for N in get_children():
			N.queue_free() #change if other non-undead nodes needed
	
	squadsize = undead.base_quantity
	
	for i in range(squadsize):
		var new_undead = SquadNode.instance()
		
		new_undead.initialize(undead.HP, undead.attack, undead.defense, undead.icon)
		add_child(new_undead)
	#create a node for each undead 
	#give them the stats
	#update sprites


func get_undead():
	return get_children()
