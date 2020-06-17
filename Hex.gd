extends Area2D

#A hex can either be empty (as in a sea tile) or be a land tile

enum {EMPTY, SEA, LAND}
var type = EMPTY

export var size = 10

var cube = Vector3(0,0,0)
var axial = Vector2(0,0)

var cube_direction = [
	Vector3(+1, -1, 0), Vector3(+1, 0, -1), Vector3(0, +1, -1), 
	Vector3(-1, +1, 0), Vector3(-1, 0, +1), Vector3(0, -1, +1), 
]


# Called when the node enters the scene tree for the first time.
func _ready():
	draw_hexagon(Vector2(0,0), size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match type:
		SEA:
			$DrawHex.color = Color( .3, .3, .3, 1)
		LAND:
			$DrawHex.color = Color( 1, 1, 1, 1)


func define_hex_point(center : Vector2, size, i):
	#returns a point 0 - 5 around Center that is Size units way from Center
	var angle_deg = 60 * i - 30
	var angle_rad =  PI / 180 * angle_deg
	return Vector2(center.x + size * cos(angle_rad),
					center.y + size  * sin(angle_rad))

func draw_hexagon(center : Vector2, size):
	var i = 0
	var from_point = Vector2(0,0)
	var array = PoolVector2Array()
	
	for i in range (6):
		#create new line with all points
		from_point = define_hex_point(center,size,i)
		array.append(from_point)
		
	array.append(define_hex_point(center,size,0)) #Connect the Point
	
	$DrawHex.polygon = array
	$CollisionPolygon2D.polygon = array


func _on_Hex_mouse_entered():
	var to_print = cube
	print(to_print)


func cube_to_axial():
	axial.x = cube.x
	axial.y = cube.y
	return axial


func axial_to_cube():
	cube.x = axial.x
	cube.z = axial.y
	cube.y = -cube.x - cube.z
	return cube


func distance_to_hex(target_hex):
	var distance = (abs(cube.x - target_hex.cube.x) + abs(cube.y - target_hex.cube.y) + abs(cube.z - target_hex.cube.z)) / 2
	if distance <= 1:
		print(distance)
	return distance
