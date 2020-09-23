extends Node2D

var HP
var current_HP
var attack
var defense


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func initialize(new_HP, new_attack, new_defense, new_icon):
	HP = new_HP
	current_HP = new_HP
	attack = new_attack
	defense = new_defense
	
	$UndeadSprite.texture = load(new_icon)
