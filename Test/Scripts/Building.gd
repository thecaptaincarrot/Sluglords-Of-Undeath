extends Node2D


enum {LABORATORY, DOCKS, AIRDOCKS, SLAVEPIT, ROTFARM, DISEASEMARKET, PLAGUECIRCUS,
		}
var type = null

var gold_production = 0
var corpse_production = 0
var contagion_production = 0

var lab_level = 0

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func change_type(change_to):
	type = change_to
	match type:
		LABORATORY:
			gold_production = 50
			corpse_production = 10
			contagion_production = 5
			$BuildingSprite.frame = 1
		DOCKS:
			gold_production = 10
			corpse_production = 5
			contagion_production = 0
		AIRDOCKS:
			gold_production = 10
			corpse_production = 5
			contagion_production = 0
		DISEASEMARKET:
			gold_production = 10
			corpse_production = 5
			contagion_production = 0
		SLAVEPIT:
			gold_production = 0
			corpse_production = 10
			contagion_production = 5
		ROTFARM:
			gold_production = 0
			corpse_production = 5
			contagion_production = 10


func get_description():
	pass
