extends PanelContainer

export (PackedScene) var RecruitPanel
export (PackedScene) var QueueLine


var player_faction
var target_island 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func initialize_menu(island, faction):
	player_faction = faction
	target_island = island
	
	$MarginContainer/HBoxContainer/BasicInformation/IslandName.text = "Island of " + island.name
	$MarginContainer/HBoxContainer/BasicInformation/IslandSize.text = "Size: " + str(len(island.hexes))
	
	#production
	$MarginContainer/HBoxContainer/BasicInformation/GoldProduction.text = "Gold: " + str(island.get_gold_production())
	$MarginContainer/HBoxContainer/BasicInformation/CorpsesProduction.text = "Corpses: " + str(island.get_corpse_production())
	$MarginContainer/HBoxContainer/BasicInformation/ContagionProduction.text = "Contagion: " + str(island.get_contagion_production())
	
	#Forces
	
	#Recruitment
	island.update_recruitment_capacity()
	$MarginContainer/HBoxContainer/FunctionButton/RecruitmentCapacity.text = "Recruitment Capacity: " + str(island.recruitment_capacity)
	update_queue()
	update_forces()


func re_initialize():
	$MarginContainer/HBoxContainer/BasicInformation/IslandName.text = "Island of " + target_island.name
	$MarginContainer/HBoxContainer/BasicInformation/IslandSize.text = "Size: " + str(len(target_island.hexes))
	
	#production
	$MarginContainer/HBoxContainer/BasicInformation/GoldProduction.text = "Gold: " + str(target_island.get_gold_production())
	$MarginContainer/HBoxContainer/BasicInformation/CorpsesProduction.text = "Corpses: " + str(target_island.get_corpse_production())
	$MarginContainer/HBoxContainer/BasicInformation/ContagionProduction.text = "Contagion: " + str(target_island.get_contagion_production())
	
	#Forces
	
	#Recruitment
	target_island.update_recruitment_capacity()
	$MarginContainer/HBoxContainer/FunctionButton/RecruitmentCapacity.text = "Recruitment Capacity: " + str(target_island.recruitment_capacity)
	update_queue()
	update_forces()


func _on_RecruitButton_pressed():
	var new_window = RecruitPanel.instance()
	new_window.rect_position.x = rect_size.x
	new_window.rect_size.y = rect_size.y
	new_window.connect("mouse_entered",get_parent(),"_on_TabContainer_mouse_entered")
	new_window.connect("mouse_exited",get_parent(),"_on_TabContainer_mouse_exited")

	get_parent().get_parent().add_child(new_window)
	new_window.check_enabled(player_faction, target_island)


func update_queue():
	#relies on target_island already being defined. If this is a problem, will have to rethink
	#1. clear queue box
	var queuebox = $MarginContainer/HBoxContainer/FunctionButton/ScrollContainer/QueueBox
	for N in queuebox.get_children():
		N.queue_free()
	
	var i = 0
	for queue_element in target_island.undead_queue:
		var new_line = QueueLine.instance()
		i = i + 1
		new_line.create(i, queue_element["type"].identity, queue_element["turns"])
		$MarginContainer/HBoxContainer/FunctionButton/ScrollContainer/QueueBox.add_child(new_line)
	print ("Queue Updated")


func update_forces():
	var skeletoncount = 0
	var zombiecount = 0
	var supercount = 0
	
	for undead in target_island.undead_array:
		match undead["type"]:
			Zombie:
				zombiecount += 1
			GlobalSkeleton:
				skeletoncount += 1
			SuperSkeleton:
				supercount += 1
	
	$MarginContainer/HBoxContainer/UndeadInfo/ScrollContainer/VBoxContainer/HBoxContainer/ZombiesNum.text = str(zombiecount)
	$MarginContainer/HBoxContainer/UndeadInfo/ScrollContainer/VBoxContainer/HBoxContainer2/SkeletonsNum.text = str(skeletoncount)
	$MarginContainer/HBoxContainer/UndeadInfo/ScrollContainer/VBoxContainer/HBoxContainer3/SupersNum.text = str(supercount)
