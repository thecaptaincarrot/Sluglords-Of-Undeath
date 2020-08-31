extends TabContainer

enum {DEFAULT, ATTACKING}
var state

var moused_over = false
signal deselect

# Called when the node enters the scene tree for the first time.
func _ready():
	state = DEFAULT


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if not moused_over and event.is_action_pressed("ui_left_click") and state == DEFAULT:
		emit_signal("deselect")
		for menu in get_parent().get_children(): #God I'm glad I'm deleting all my menus after this
			if menu.name != "TabContainer" and menu.name != "AttackMenu":
				menu.queue_free()
		get_parent().get_node("AttackMenu").hide()
		get_parent().hide()


func _on_TabContainer_mouse_entered():
	moused_over = true


func _on_TabContainer_mouse_exited():
	moused_over = false


func _on_AttackMenu_mouse_exited():
	moused_over = false


