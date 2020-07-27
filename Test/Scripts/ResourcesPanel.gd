extends Panel

var player_faction = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_faction != null:
		$Gold.text = "Gold: " + str(player_faction.gold)
		$Corpses.text = "Corpses: " + str(player_faction.corpses)
		$Contagion.text = "Contagion: " + str(player_faction.contagion)
