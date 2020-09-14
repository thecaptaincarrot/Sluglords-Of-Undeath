extends Control

var hex
var island
var faction

signal build
signal deselect

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event.is_action_pressed("ui_left_click") and event.pressed and is_visible():
		var evLocal
		var clicked_in_rect = false
		
		for child in get_children():
			if child.is_visible():
				evLocal = child.make_input_local(event)
				if Rect2(Vector2(0,0),child.rect_size).has_point(evLocal.position):
					clicked_in_rect = true
		if !clicked_in_rect:
			for N in island.get_hexes():
				N.deselect() #Should this be a signal? hmmmmm
			hide()


func new_hex_selected(new_hex):
	if island != null:
		for N in island.get_hexes():
			N.deselect() #Should this be a signal? hmmmmm
	
	if new_hex == hex and !island.is_selected:
		$UnownedHexTabs.current_tab = 1
		for N in island.get_hexes():
			N.select()
	else:
		$UnownedHexTabs.current_tab = 0
		if hex != null:
			hex.deselect()
	
	hex = new_hex
	island = new_hex.island
	faction = null #This should ALWAYS be the player faction...
	
	hex.select()
	
	$UnownedHexTabs.hex = hex
	$UnownedHexTabs.island = island
	$UnownedHexTabs.refresh_hex_menu()
	
	close_all_but_main()
	show()


func close_all_but_main():
	for child in get_children():
		child.hide()
	
	$UnownedHexTabs.show()	


func refresh_all():
	for child in get_children():
		child.hide()
	
	$UnownedHexTabs.refresh_hex_menu()
	
	$UnownedHexTabs.show()
	show()


func _on_UnownedHexTabs_tab_changed(tab):
	close_all_but_main()
	if tab == 0:
		island.is_selected = false
		for N in island.get_hexes():
			N.deselect()
		hex.select()
	elif tab == 1:
		island.is_selected = true
		for N in island.get_hexes():
			N.select()
