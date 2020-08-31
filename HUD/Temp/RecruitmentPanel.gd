extends PanelContainer

signal recruit

var target_island 
var target_faction

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func check_enabled(faction, island):
	for N in $ScrollContainer/DescriptionsContainer.get_children():
		N.init_to_target()
		N.build_out_info()
		N.check_enabled(faction, island)
		N.connect("recruit",island,"add_to_queue")
		N.connect("recruit",faction,"recruit_payment")
		N.connect("recruit",get_parent(),"recruit_downwell")
		N.connect("recruit",self,"re_check_enabled")
		target_island = island
		target_faction = faction


func re_check_enabled(junk):
	for N in $ScrollContainer/DescriptionsContainer.get_children():
		N.check_enabled(target_faction, target_island)


func remove_self(junk):
	get_parent().re_initialize()
	queue_free()
