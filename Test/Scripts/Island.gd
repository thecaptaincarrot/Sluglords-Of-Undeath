extends Node2D

var identity = "Island"

var island_name = ""
var hexes = []

var prefixes = ["Ta", "Go", "Cha", "Naox", "Ka", "Dra", "Tho", "Ul", "Ku"]
var midfixes = ["t", "d", "b", "x", "r", "s", "v"]
var suffixes =  ["or", "", "as", "en", "auw"]

var faction_owner = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func init_island():
	island_name = generate_name()
	name = island_name
	var best_position = Vector2(-9999,9999)
	
	var size = hexes[0].size
	#find top right most hex, prioritizing topness, then rightness
	for hex in hexes:
		var q = hex.axial.x
		var r = hex.axial.y
		
		
		var pixel_center = axial_to_pixel(q,r,size)
		if pixel_center.y < best_position.y:
			best_position = pixel_center
		elif pixel_center.y <= best_position.y and pixel_center.x > best_position.x:
			best_position = pixel_center
		
	$IslandNameLabel.rect_global_position = Vector2(best_position.x, best_position.y - (size * 3 / 2))
	$IslandNameLabel.text = island_name


func init_pillar():
	island_name = "The Pillar of Thras"
	name = island_name
	var best_position = Vector2(-9999,9999)
	
	var size = hexes[0].size
	#find top right most hex, prioritizing topness, then rightness
	for hex in hexes:
		var q = hex.axial.x
		var r = hex.axial.y
		
		
		var pixel_center = axial_to_pixel(q,r,size)
		if pixel_center.y < best_position.y:
			best_position = pixel_center
		elif pixel_center.y <= best_position.y and pixel_center.x > best_position.x:
			best_position = pixel_center
		
	$IslandNameLabel.rect_global_position = Vector2(best_position.x, best_position.y - (size * 3 / 2))
	$IslandNameLabel.text = island_name


func get_hexes():
	return hexes


func clear_owner():
	faction_owner = null
	for hex in hexes:
		hex.faction_owner = null


func generate_name():
	randomize()
	var card_pick = randi() % len(prefixes)
	var prefix = prefixes[card_pick]
	
	card_pick = randi() % len(midfixes)
	var midfix = midfixes[card_pick]
	
	card_pick = randi() % len(suffixes)
	var suffix = suffixes[card_pick]
	
	return prefix + midfix + suffix


func axial_to_pixel(q,r,size):
	var x  = size * (sqrt(3) * q + (sqrt(3) / 2) * r)
	var y = size * ((3.0 / 2) * r)
	return Vector2(x,y)


