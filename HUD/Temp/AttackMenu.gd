extends PanelContainer

var temp_attack = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func cancel_attack():
	if temp_attack != null:
		#All the undead should be sent back to the island.
		temp_attack.empty_undead()

		temp_attack.queue_free()
		temp_attack = null
		
		hide()
