extends Node2D

#Scene declarations
export (PackedScene) var ToolTip

#Easy Node Access
onready var ColorHex = $HeightSensitive/HexArea/Colorhex
var Map #declared by the map itself
var island

onready var HexNode = get_parent() #Will this ever fuck up?
#Ignore more complex functions of buildings.

enum {EMPTY, SEA, LAND, PILLAR}

var type
var faction_owner

var cube = Vector3(0,0,0)
var axial = Vector2(0,0)
var offset = Vector2(0,0)

#fundamental variables
var gold_production = 2
var corpse_production = 2
var contagion_production = 2

var border_thickness = 2

var size = 64 #Obsolete because of graphic hex but used for some helper functions

#
var building
var building_turns_left = 0

var feature

# Called when the node enters the scene tree for the first time.
func _ready():
	draw_hexagon(Vector2(0,0), 64)


func _enter_tree():
	$HeightSensitive/HexArea.MapHexNode = get_parent()
	$HeightSensitive/HexArea.Hex = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match type:
		EMPTY:
			$HeightSensitive/Graphics/Hex.frame = 0
		PILLAR:
			$HeightSensitive/Graphics/Hex.frame = 1
		SEA:
			$HeightSensitive/Graphics/Hex.frame = 0
		LAND:
			$HeightSensitive/Graphics/Hex.frame = 1
	pass

#Initialization 
func define_hex_point(center : Vector2, hex_size, i):
	#returns a point 0 - 5 around Center that is Size units way from Center
	var angle_deg = 60 * i
	var angle_rad =  PI / 180 * angle_deg
	return Vector2(center.x + hex_size * cos(angle_rad),
					center.y + hex_size  * sin(angle_rad) * .6666666666)


func draw_hexagon(center : Vector2, hex_size):
	var from_point = Vector2(0,0)
	var array = PoolVector2Array()
	
	for i in range (6):
		#create new line with all points
		from_point = define_hex_point(center,hex_size,i)
		array.append(from_point)
		
	array.append(define_hex_point(center,hex_size,0)) #Connect the Point
	
	$HeightSensitive/HexArea/CollisionHex.polygon = array
	$HeightSensitive/HexArea/Colorhex.polygon = array
#	#Draw border hex 2 bigger
#	from_point = Vector2(0,0)
#	var new_array = PoolVector2Array()
#
#	for i in range (6):
#		#create new line with all points
#		from_point = define_hex_point(center,hex_size + border_thickness,i)
#		new_array.append(from_point)
#
#	new_array.append(define_hex_point(center,hex_size + border_thickness,0)) #Connect the Point
#
#	$BorderHex.polygon = new_array
#	$BorderHex.color = Color(1.0,0,0,0)


func height_offset(height):
	$HeightSensitive.position.y -= height


#Utility Functions
func cube_to_axial():
	axial.x = cube.x
	axial.y = cube.y
	return axial


func axial_to_cube():
	cube.x = axial.x
	cube.z = axial.y
	cube.y = -cube.x - cube.z
	return cube


func cube_to_offset():
	offset.x = cube.x
	offset.y = cube.z + (cube.x + (int(cube.x)&1)) / 2


func distance_to_hex(target_hex):
	var distance = (abs(cube.x - target_hex.cube.x) + abs(cube.y - target_hex.cube.y) + abs(cube.z - target_hex.cube.z)) / 2
	return distance


func get_neighbors():
	return Map.get_neighbors(self)

#Update functions
func update_production():
	gold_production = 5
	corpse_production = 1
	contagion_production = 0
	if building != null and building_turns_left <= 0: #Any reason why a building would provide resources if it has turns left on building? upgrades!?
		gold_production += building.gold_production
		corpse_production += building.corpse_production
		contagion_production += building.contagion_production
	if feature != null:
		gold_production += feature.gold_production
		corpse_production += feature.corpse_production
		contagion_production += feature.contagion_production


func update_building_sprite():
	if building != null:
		if building_turns_left <= 0:
			$HeightSensitive/Graphics/Building.texture = load(building.texture)
		else:
			$HeightSensitive/Graphics/Building.texture = load(building.in_progress_texture)

#Building Functions:
func insta_build(new_building): #Building is a camel case string name of building
	#to be changed
	building = new_building
	update_building_sprite()
	update_production()


func build(new_building):
	print("Trying to Build" + new_building.identity)
	building = new_building
	building_turns_left = new_building.build_time
	update_building_sprite()
	#Building is
	 


