extends Node2D

export (PackedScene) var Hex

var size = 16
var map_size = 9
var hex_map = {}

var neighbors = [Vector2(0,-1), Vector2(1,-1), Vector2(-1,0), Vector2(1,0), Vector2(-1,1), Vector2(0,1)]

var center_hex

# Called when the node enters the scene tree for the first time.
func _ready():
	clear_map()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func clear_map():
	hex_map.clear()
	
	for q in range(map_size * -1, map_size + 1):
		var new_dict = {}
		for r in range(map_size * -1, map_size + 1):
			var new_hex = Hex.instance()
			new_hex.axial.x = q
			new_hex.axial.y = r
			new_hex.axial_to_cube()
			new_hex.size = size - 1 #pixel barrier
			new_hex.position = axial_to_pixel(q,r)
			new_dict[r] = new_hex
			new_hex.connect("moused_in", self, "hex_mouse_in")
			new_hex.connect("moused_out", self, "hex_mouse_out")
			add_child(new_hex)
		hex_map[q] = new_dict
		
	#center point is 0,0 don't center camera dumbass
	#All tiles within map_size tiles of the point 0,0 are sea tiles, all others
	# 	are empty
	center_hex = hex_map[0][0]
	for q in range(map_size * -1, map_size + 1):
		for r in range(map_size * -1, map_size + 1):
			if hex_map[q][r].distance_to_hex(center_hex) > map_size:
				hex_map[q][r].queue_free()
				hex_map[q][r] = null
			else:
				hex_map[q][r].type = hex_map[q][r].LAND


func axial_to_pixel(q,r):
	var x  = size * (sqrt(3) * q + (sqrt(3) / 2) * r)
	var y = size * ((3.0 / 2) * r)
	return Vector2(x,y)


func hex_mouse_in(hex):
	hex.type = hex.SEA
	
	var neighbors = get_neighbors(hex)
	
	for N in neighbors:
		N.type = N.SEA
	


func hex_mouse_out(hex):
	hex.type = hex.LAND
	
	var neighbors = get_neighbors(hex)
	
	for N in neighbors:
		N.type = N.LAND


func _on_Button_pressed():
	get_tree().change_scene("res://Test/TestMenu.tscn")


func get_neighbors(hex):
	var hex_neighbors = []
	
	for direction in neighbors:
		
		var new_x = hex.axial.x + direction.x
		var new_y = hex.axial.y + direction.y
		
		new_x = int(new_x)
		new_y = int(new_y)
		if new_x in hex_map:
			if new_y in hex_map[new_x] and hex_map[new_x][new_y] != null:
				hex_neighbors.append(hex_map[new_x][new_y])
	return hex_neighbors
