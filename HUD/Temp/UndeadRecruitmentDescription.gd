extends VBoxContainer

export(String,"Always Enabled","Osseorium") var enable_condition

export (String,"Null","Zombie","Skeleton","Super Skeleton") var target

var target_undead = GlobalSkeleton
var enabled = false

signal recruit

# Called when the node enters the scene tree for the first time.
func _ready():
	init_to_target()
	build_out_info()


func init_to_target():
	print("target " + target)
	match target:
		"Zombie":
			target_undead = Zombie
		"Skeleton":
			target_undead = GlobalSkeleton
		"Super Skeleton":
			target_undead = SuperSkeleton


func build_out_info():
	#Image
	$HBoxContainer/VBoxContainer4/Image.texture = load(target_undead.icon)
	
	#basic info
	$HBoxContainer/VBoxContainer/Identity.text = target_undead.identity
	$HBoxContainer/VBoxContainer/Description.text = target_undead.description
	
	#stats
	$HBoxContainer/VBoxContainer3/HBoxContainer/VBoxContainer/Attack.text = "Attack: " + str(target_undead.attack)
	$HBoxContainer/VBoxContainer3/HBoxContainer/VBoxContainer/Defense.text = "Defense: " + str(target_undead.defense)
	$HBoxContainer/VBoxContainer3/HBoxContainer/VBoxContainer/Health.text = "Health: " + str(target_undead.HP)
	$HBoxContainer/VBoxContainer3/HBoxContainer/VBoxContainer2/Quantity.text = "Quantity: " + str(target_undead.base_quantity)
	$HBoxContainer/VBoxContainer3/HBoxContainer/VBoxContainer2/Complexity.text = "Complexity: " + str(target_undead.complexity)
	
	#Costs
	if target_undead.gold_cost <= 0:
		$HBoxContainer/VBoxContainer2/GoldCost.hide()
	else:
		$HBoxContainer/VBoxContainer2/GoldCost.show()
	$HBoxContainer/VBoxContainer2/GoldCost.text = "Gold: " + str(target_undead.gold_cost)
	
	if target_undead.corpses_cost <= 0:
		$HBoxContainer/VBoxContainer2/CorpsesCost.hide()
	else:
		$HBoxContainer/VBoxContainer2/CorpsesCost.show()
	$HBoxContainer/VBoxContainer2/CorpsesCost.text = "Corpses: " + str(target_undead.corpses_cost)
	
	if target_undead.contagion_cost <= 0:
		$HBoxContainer/VBoxContainer2/ContagionCost.hide()
	else:
		$HBoxContainer/VBoxContainer2/ContagionCost.show()
	$HBoxContainer/VBoxContainer2/ContagionCost.text = "Contagion: " + str(target_undead.contagion_cost)


func check_enabled(faction, island):
	var cost_bool = false
	var condition_bool = true
	
	$HBoxContainer/VBoxContainer2/ErrorMessage.text = ""
	$HBoxContainer/VBoxContainer2/ErrorMessage.hide()
	if faction.gold >= target_undead.gold_cost and faction.corpses >= target_undead.corpses_cost and faction.contagion >= target_undead.contagion_cost:
		cost_bool = true
	else:
		$HBoxContainer/VBoxContainer2/ErrorMessage.text = "insufficient resources"
		cost_bool = false
		
	if target_undead.requires_osseorium:
		condition_bool = false
		for hex in island.hexes:
			print(hex.building)
			if hex.building == Osseorium:
				condition_bool = true
				print("found osseorium:")
		if condition_bool == false:
			$HBoxContainer/VBoxContainer2/ErrorMessage.text = $HBoxContainer/VBoxContainer2/ErrorMessage.text + "\nRequires Osseorium"
	
	if cost_bool and condition_bool:
		$HBoxContainer/VBoxContainer2/RecruitButton.disabled = false
	else:
		$HBoxContainer/VBoxContainer2/RecruitButton.disabled = true
		$HBoxContainer/VBoxContainer2/ErrorMessage.show()
	


func _on_RecruitButton_pressed():
	emit_signal("recruit",target_undead)
