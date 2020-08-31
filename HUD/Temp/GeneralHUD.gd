extends Control

var playerfaction = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playerfaction != null:
		update_player_resources()


func _on_Button_pressed():
	var _worked = get_tree().change_scene("res://Test/TestMenu.tscn")


func update_player_resources():
	pass
	
