extends Area2D

var Hex
var MapHexNode

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		MapHexNode.clicked.append(Hex)
		MapHexNode.set_process(true)
