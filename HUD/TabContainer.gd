extends TabContainer

var moused_over = false
signal deselect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if not moused_over and event.is_action_pressed("ui_left_click"):
		emit_signal("deselect")
		get_parent().queue_free()


func _on_TabContainer_mouse_entered():
	moused_over = true


func _on_TabContainer_mouse_exited():
	moused_over = false
