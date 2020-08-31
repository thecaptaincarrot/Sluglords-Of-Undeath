extends Node2D

var clicked = []

signal hex_clicked #sends one hex after it figures out that a hex was clicked

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	set_process(false)
	
	var topmost_clicked = clicked.front()
	for N in clicked:
		if  N.z_index > topmost_clicked.z_index:
			topmost_clicked = N
	clicked.clear()
	emit_signal("hex_clicked",topmost_clicked)
