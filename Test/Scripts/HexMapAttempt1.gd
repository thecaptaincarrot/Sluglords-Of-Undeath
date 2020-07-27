extends Node

onready var map = $Map

var turn = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RemapHUDButton_pressed():
	$HUDCanvas/NewMapPanel.show()


func _on_Remap1_pressed():

	
	map.size = $HUDCanvas/NewMapPanel/HexSize/PixelSelect.value
	map.map_size = $HUDCanvas/NewMapPanel/MapSize/MapSizeSelect.value
	map.min_island_size = $HUDCanvas/NewMapPanel/MinIslandSize/MinIslandSelect.value
	map.max_island_size = $HUDCanvas/NewMapPanel/MaxIslandSize/MaxIslandSelect.value
	map.distance_between_islands = $HUDCanvas/NewMapPanel/IslandSeparation/SeparationSelect.value

	map.clear_map()
	map.build_map_old()


func _on_Remap2_pressed():
	map.size = $HUDCanvas/NewMapPanel/HexSize/PixelSelect.value
	map.map_size = $HUDCanvas/NewMapPanel/MapSize/MapSizeSelect.value
	map.min_island_size = $HUDCanvas/NewMapPanel/MinIslandSize/MinIslandSelect.value
	map.max_island_size = $HUDCanvas/NewMapPanel/MaxIslandSize/MaxIslandSelect.value
	map.distance_between_islands = $HUDCanvas/NewMapPanel/IslandSeparation/SeparationSelect.value

	map.clear_map()
	map.build_map_new()
