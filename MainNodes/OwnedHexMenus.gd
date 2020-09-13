extends Control

var hex
var island
var faction

signal build

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
	faction = island.faction_owner #This should ALWAYS be the player faction...
	
	$OwnedHexTabs.hex = hex
	$OwnedHexTabs.island = island
	$OwnedHexTabs.refresh_hex_menu()
	
	$BuildPanel.update_identities(hex,island,faction)
	
	for child in get_children():
		child.hide()
	
	$OwnedHexTabs.show()	
	show()


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
