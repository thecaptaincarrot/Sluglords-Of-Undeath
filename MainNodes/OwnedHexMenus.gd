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
	if (event is InputEventMouseButton) and event.pressed and is_visible():
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
	$OwnedHexTabs.current_tab = 0
	hex = new_hex
	island = new_hex.island
	faction = island.faction_owner #This should ALWAYS be the player faction...
	
	for N in island.get_hexes():
		N.deselect() #Should this be a signal? hmmmmm
	
	hex.select()
	
	$OwnedHexTabs.hex = hex
	$OwnedHexTabs.island = island
	$OwnedHexTabs.refresh_hex_menu()
	
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
		for N in island.get_hexes():
			N.deselect()
		hex.select()
	elif tab == 1:
		for N in island.get_hexes():
			N.select()
