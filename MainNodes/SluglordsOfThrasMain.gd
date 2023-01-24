extends Node2D

#scene variables
export (PackedScene) var Faction

#Easy Node Access
onready var Map = $Map

onready var HUD = $HUDcanvas/PermanentHUD
onready var ContextWindow = $HUDcanvas/ContextMenus

var player_faction

var turn = 1

signal turn_over #I don't think we can send turn over like this since all players need to go sequentially... Unless


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

