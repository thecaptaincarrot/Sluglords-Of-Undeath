extends Area2D

export (PackedScene) var ToolTip

var identity = "Hex"
var color setget change_color

#A hex can either be empty (as in a sea tile) or be a land tile
#basic Types
enum {EMPTY, SEA, LAND, PILLAR}
#special types
enum {NOTHING, }
#Building Types
enum {LABORATORY, DOCKS, AIRDOCKS, SLAVEPIT, ROTFARM, DISEASEMARKET, PLAGUECIRCUS,
		}

var gold_production = 2
var corpse_production = 2
var contagion_production = 2

var type = EMPTY setget change_type

var island

export var size = 10

var cube = Vector3(0,0,0)
var axial = Vector2(0,0)

#***Traits and types that need to be logged***
var sea_facing = false
var building = null
var faction_owner = null
var special_type = NOTHING
var troops_here = false

#***Utility variables and signals***
var moused_over = false

signal moused_in
signal moused_out
signal clicked

var tooltip

# Called when the node enters the scene tree for the first time.
func _ready():
	draw_hexagon(Vector2(0,0), size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func define_hex_point(center : Vector2, hex_size, i):
	#returns a point 0 - 5 around Center that is Size units way from Center
	var angle_deg = 60 * i - 30
	var angle_rad =  PI / 180 * angle_deg
	return Vector2(center.x + hex_size * cos(angle_rad),
					center.y + hex_size  * sin(angle_rad))

func draw_hexagon(center : Vector2, hex_size):
	var from_point = Vector2(0,0)
	var array = PoolVector2Array()
	
	for i in range (6):
		#create new line with all points
		from_point = define_hex_point(center,hex_size,i)
		array.append(from_point)
		
	array.append(define_hex_point(center,hex_size,0)) #Connect the Point
	
	$DrawHex.polygon = array
	$CollisionHex.polygon = array
	
	#Draw border hex 1 bigger
	from_point = Vector2(0,0)
	var new_array = PoolVector2Array()
	
	for i in range (6):
		#create new line with all points
		from_point = define_hex_point(center,hex_size + 1,i)
		new_array.append(from_point)
		
	new_array.append(define_hex_point(center,hex_size + 1,0)) #Connect the Point
	
	$BorderHex.polygon = new_array
	$BorderHex.color = Color(1.0,0,0,0)


func _on_Hex_mouse_entered():
	emit_signal("moused_in",self)
	moused_over = true
	if type == LAND:
		$TooltipTimer.start()

func _on_Hex_mouse_exited():
	emit_signal("moused_out",self)
	moused_over = false
	$TooltipTimer.stop()
	if tooltip != null:
		tooltip.queue_free()
		tooltip = null

func _on_TooltipTimer_timeout():
	tooltip = build_tooltip()
	get_parent().add_child(tooltip)
	


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
	return distance


func build_tooltip():
	var new_tooltip = ToolTip.instance()
	var owner_name = ""
	if faction_owner == null:
		owner_name = "None"
	else:
		owner_name = faction_owner.name
	new_tooltip.get_node("ToolTip").text = "Hex position: " + str(axial) + "\n Island: " + island.island_name + "\n Owner:" + owner_name
	
	return new_tooltip


func get_neighbors():
	var hexmap = get_parent()
	return hexmap.get_neighbors(self)


func check_sea_facing():
	var neighbors = get_neighbors()
	sea_facing = false
	for N in neighbors:
		if N.type == N.SEA:
			sea_facing = true


func build(building): #Building is a camel case string name of building
	match building:
		"Laboratory":
			$Building.change_type($Building.LABORATORY)


func update_production():
	gold_production = 5 + $Building.gold_production + $Feature.gold_production
	corpse_production = 1 + $Building.corpse_production + $Feature.corpse_production
	contagion_production = 0 + $Building.contagion_production + $Feature.contagion_production


func change_color(new_color):
	$DrawHex.color = new_color


func change_type(new_value):
	match new_value:
		SEA:
			$DrawHex.color = Color( .3, .3, .3, 1)
		LAND:
			if faction_owner == null:
				$DrawHex.color = Color( 1, 1, 1, 1)
			else:
				$DrawHex.color = faction_owner.color
		PILLAR:
			$DrawHex.color = Color(0,1,1,1)
	type = new_value


func _input(event):
	if moused_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		emit_signal("clicked",self)
