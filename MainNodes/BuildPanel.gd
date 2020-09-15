extends Panel
#Mostly a placeholder script.
#Later building descriptions should be created dyanmically based on the research
#of the player faciton.

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func update_identities(hex,island,faction):
	for description in $ScrollContainer/ScrollVBox.get_children():
		print(description)
		description.hex = hex
		description.island = island
		description.faction = faction
		description.update_info()


func _on_BuildButton_pressed():
	if is_visible():
		hide()
	else:
		show()
