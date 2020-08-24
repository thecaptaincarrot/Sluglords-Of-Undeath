extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	draw_polyline ($Path2D.curve.get_baked_points(), Color.aquamarine, 5, true)


func calculate_path():
	#must find the shorted path between two islands. The ending point can be any
	#point on the island
	#The starting point
	pass
