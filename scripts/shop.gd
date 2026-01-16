extends Control
@onready var message_label = $s/ui/message
@onready var close = $close

func _ready():
	message_label.text = "Welcome to the shop!"
	if Global.fball_bought:
		$s/ui/upg2.disabled = true
	if Global.iblast_bought:
		$s/ui/upg4.disabled = true
	if Global.bos_bought:
		$s/ui/upg6.disabled = true
	if Global.discharge_bought:
		$s/ui/upg8.disabled = true
	$s/ui/upg1/upg1cost.text = "%d Coins" % Global.upg1cost
	$s/ui/upg2/upg2cost.text = "%d Coins" % Global.upg2cost
	$s/ui/upg3/upg3cost.text = "%d Coins" % Global.upg3cost
	$s/ui/upg4/upg4cost.text = "%d Coins" % Global.upg4cost
	$s/ui/upg5/upg5cost.text = "%d Coins" % Global.upg5cost
	$s/ui/upg6/upg6cost.text = "%d Coins" % Global.upg6cost
	$s/ui/upg7/upg7cost.text = "%d Coins" % Global.upg7cost
	$s/ui/upg8/upg8cost.text = "%d Coins" % Global.upg8cost
	if Global.level >= 5:
		$s/ui/upg3/Lvl5Overlay.hide()
		$s/ui/upg4/Lvl5Overlay.hide()
	if Global.level >= 10:
		$s/ui/upg5/Lvl10Overlay.hide()
		$s/ui/upg6/Lvl10Overlay.hide()
	if Global.level >= 15:
		$s/ui/upg7/Lvl15Overlay.hide()
		$s/ui/upg8/Lvl15Overlay.hide()
func _on_upg_1_pressed() -> void:
	if Global.currency < Global.upg1cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg1cost
	Global.upg1cost = int(ceil(Global.upg1cost * 1.15))
	Global.attack_bonus += 2
	Global.save_game()
	$s/ui/upg1/upg1cost.text = "%d Coins" % Global.upg1cost
	message_label.text = "You gained 2 attack strength"


func _on_close_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_upg_2_pressed() -> void:
	Global.fball_bought = true
	
	if Global.currency < Global.upg2cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg2cost
	if "fireball_spell" not in Global.inventory:
		Global.inventory.append("fireball_spell")
	Global.save_game()
	message_label.text = "You gained a new spell"
	if Global.fball_bought:
		$s/ui/upg2.disabled = true


func _on_upg_3_pressed() -> void:
	if Global.currency < Global.upg3cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg3cost
	Global.upg3cost = int(ceil(Global.upg3cost * 1.15))
	Global.attack_bonus += 5
	Global.save_game()
	$s/ui/upg3/upg3cost.text = "%d Coins" % Global.upg3cost
	message_label.text = "You gained 5 attack strength"


func _on_upg_4_pressed() -> void:
	Global.iblast_bought = true
	
	if Global.currency < Global.upg4cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg4cost
	if "iceblast_spell" not in Global.inventory:
		Global.inventory.append("iceblast_spell")
	Global.save_game()
	message_label.text = "You gained a new spell"
	if Global.iblast_bought:
		$s/ui/upg4.disabled = true


func _on_upg_5_pressed() -> void:
	if Global.currency < Global.upg5cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg5cost
	Global.upg5cost = int(ceil(Global.upg5cost * 1.15))
	Global.attack_bonus += 10
	Global.save_game()
	$s/ui/upg5/upg5cost.text = "%d Coins" % Global.upg5cost
	message_label.text = "You gained 10 attack strength"


func _on_upg_6_pressed() -> void:
	Global.bos_bought = true
	
	if Global.currency < Global.upg6cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg6cost
	if "bos_spell" not in Global.inventory:
		Global.inventory.append("bos_spell")
	Global.save_game()
	message_label.text = "You gained a new spell"
	if Global.bos_bought:
		$s/ui/upg6.disabled = true


func _on_upg_7_pressed() -> void:
	if Global.currency < Global.upg7cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg7cost
	Global.upg7cost = int(ceil(Global.upg7cost * 1.15))
	Global.attack_bonus += 20
	Global.save_game()
	$s/ui/upg7/upg7cost.text = "%d Coins" % Global.upg7cost
	message_label.text = "You gained 20 attack strength"


func _on_upg_8_pressed() -> void:
	Global.discharge_bought = true
	
	if Global.currency < Global.upg8cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg8cost
	if "discharge_spell" not in Global.inventory:
		Global.inventory.append("discharge_spell")
	Global.save_game()
	message_label.text = "You gained a new spell"
	if Global.discharge_bought:
		$s/ui/upg8.disabled = true
