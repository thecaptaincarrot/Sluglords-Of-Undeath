extends Node2D

var neighbors = [Vector2(0,-1), Vector2(1,-1), Vector2(-1,0), Vector2(1,0), Vector2(-1,1), Vector2(0,1)]
onready var hex_map = get_parent().hex_map

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func get_neighbors(hex):
	var hex_neighbors = []
	
	hex_map = get_parent().hex_map
	
	for direction in neighbors:
		
		var new_x = hex.axial.x + direction.x
		var new_y = hex.axial.y + direction.y
		
		new_x = int(new_x)
		new_y = int(new_y)
		if new_x in hex_map:
			if new_y in hex_map[new_x] and hex_map[new_x][new_y] != null:
				hex_neighbors.append(hex_map[new_x][new_y])
	return hex_neighbors
