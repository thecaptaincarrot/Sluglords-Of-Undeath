extends Label


var maximum_width = 300


# Called when the node enters the scene tree for the first time.
func _ready():
	rect_position = get_global_mouse_position()
	rect_position.y -= rect_size.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if rect_size.x > maximum_width:
		autowrap = true
		rect_size.x = 300

func _input(event):
	if event is InputEventMouseMotion:
		rect_position = event.position
		rect_position.y -= rect_size.y
