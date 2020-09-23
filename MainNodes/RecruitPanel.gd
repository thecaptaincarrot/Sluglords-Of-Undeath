extends Panel

#the recruit panel should eventually dynamically create the descriptions based on the
#undead that are available.

#also show unvailable checkbox.


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RecruitButton_pressed():
	if is_visible():
		hide()
	else:
		show()


func get_descriptions():
	return $RecruitmentBox/VBoxContainer.get_children()
