extends Control

var hex
var island
var faction

signal build
signal deselect

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


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
		$OwnedHexTabs.current_tab = 1
		for N in island.get_hexes():
			N.select()
	else:
		$OwnedHexTabs.current_tab = 0
		if hex != null:
			hex.deselect()
	
	hex = new_hex
	island = new_hex.island
	faction = island.faction_owner #This should ALWAYS be the player faction...
	

	
	hex.select()
	
	$OwnedHexTabs.hex = hex
	$OwnedHexTabs.island = island
	$OwnedHexTabs.refresh_hex_menu()
	$OwnedHexTabs.refresh_island_menu()
	
	$BuildPanel.update_identities(hex,island,faction)
	
	close_all_but_main()
	show()


func close_all_but_main():
	for child in get_children():
		child.hide()
	
	$OwnedHexTabs.show()	


func refresh_all():
	for child in get_children():
		child.hide()
	
	$OwnedHexTabs.refresh_hex_menu()
	$OwnedHexTabs.refresh_island_menu()
	$BuildPanel.update_identities(hex,island,faction)
	
	$OwnedHexTabs.show()
	show()

func _on_build(building):
	hex.build(building)
	faction.build_payment(building)
	
	refresh_all()


func _on_OwnedHexTabs_tab_changed(tab):
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
