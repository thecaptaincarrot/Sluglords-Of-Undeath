extends Control

var hex
var island


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if (event is InputEventMouseButton) and event.pressed:
		var evLocal
		var clicked_in_rect = false
		
		for child in get_children():
			if child.is_visible():
				evLocal = child.make_input_local(event)
				if Rect2(Vector2(0,0),child.rect_size).has_point(evLocal.position):
					clicked_in_rect = true
		if !clicked_in_rect:
			hide()


func new_hex_selected(new_hex):
	hex = new_hex
	island = new_hex.island
	$OwnedHexTabs.hex = hex
	$OwnedHexTabs.island = island
	$OwnedHexTabs.refresh_hex_menu()
	for child in get_children():
		child.hide()
	
	$OwnedHexTabs.show()	
	show()


