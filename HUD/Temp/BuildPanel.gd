extends PanelContainer



# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func check_technology(faction):
	#placeholder. At some point, only add descriptions that you have researched
	pass


func check_enabled(faction, hex):
	for N in $ScrollContainer/DescriptionsContaimer.get_children():
		N.init_to_target()
		N.build_out_info()
		N.check_enabled(faction, hex)
		N.connect("build",hex,"build")
		N.connect("build",faction,"build_payment")
		N.connect("build",self,"remove_self")


func remove_self(junk):
	get_parent().re_initialize()
	queue_free()
	
