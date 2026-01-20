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
	if Global.wfire_bought:
		$s/ui/upg10.disabled = true
	if Global.cquake_bought:
		$s/ui/upg13.disabled = true
	$s/ui/upg1/upg1cost.text = "%s Coins" % Global.format_number(Global.upg1cost)
	$s/ui/upg2/upg2cost.text = "%s Coins" % Global.format_number(Global.upg2cost)
	$s/ui/upg3/upg3cost.text = "%s Coins" % Global.format_number(Global.upg3cost)
	$s/ui/upg4/upg4cost.text = "%s Coins" % Global.format_number(Global.upg4cost)
	$s/ui/upg5/upg5cost.text = "%s Coins" % Global.format_number(Global.upg5cost)
	$s/ui/upg6/upg6cost.text = "%s Coins" % Global.format_number(Global.upg6cost)
	$s/ui/upg7/upg7cost.text = "%s Coins" % Global.format_number(Global.upg7cost)
	$s/ui/upg8/upg8cost.text = "%s Coins" % Global.format_number(Global.upg8cost)
	$s/ui/upg9/upg9cost.text = "%s Coins" % Global.format_number(Global.upg9cost)
	$s/ui/upg10/upg10cost.text = "%s Coins" % Global.format_number(Global.upg10cost)
	$s/ui/upg11/upg11cost.text = "%s Coins" % Global.format_number(Global.upg11cost)
	$s/ui/upg12/upg12cost.text = "%s Coins" % Global.format_number(Global.upg12cost)
	$s/ui/upg13/upg13cost.text = "%s Coins" % Global.format_number(Global.upg13cost)
	$s/ui/upg14/upg14cost.text = "%s Coins" % Global.format_number(Global.upg14cost)
	if Global.level >= 5:
		$s/ui/upg3/Lvl5Overlay.hide()
		$s/ui/upg4/Lvl5Overlay.hide()
	if Global.level >= 10:
		$s/ui/upg5/Lvl10Overlay.hide()
		$s/ui/upg6/Lvl10Overlay.hide()
	if Global.level >= 15:
		$s/ui/upg7/Lvl15Overlay.hide()
		$s/ui/upg8/Lvl15Overlay.hide()
	if Global.level >= 20:
		$s/ui/upg9/Lvl20Overlay.hide()
		$s/ui/upg10/Lvl20Overlay.hide()
		$s/ui/upg11/Lvl20Overlay.hide()
	if Global.level >= 25:
		$s/ui/upg12/Lvl25Overlay.hide()
		$s/ui/upg13/Lvl25Overlay.hide()
		$s/ui/upg14/Lvl25Overlay.hide()
func _on_upg_1_pressed() -> void:
	if Global.currency < Global.upg1cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg1cost
	Global.upg1cost = int(ceil(Global.upg1cost * 1.15))
	Global.attack_bonus += 2
	Global.save_game()
	$s/ui/upg1/upg1cost.text = "%s Coins" % Global.format_number(Global.upg1cost)
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
	$s/ui/upg2.disabled = true


func _on_upg_3_pressed() -> void:
	if Global.currency < Global.upg3cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg3cost
	Global.upg3cost = int(ceil(Global.upg3cost * 1.15))
	Global.attack_bonus += 5
	Global.save_game()
	$s/ui/upg3/upg3cost.text = "%s Coins" % Global.format_number(Global.upg3cost)
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
	$s/ui/upg4.disabled = true


func _on_upg_5_pressed() -> void:
	if Global.currency < Global.upg5cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg5cost
	Global.upg5cost = int(ceil(Global.upg5cost * 1.15))
	Global.attack_bonus += 10
	Global.save_game()
	$s/ui/upg5/upg5cost.text = "%s Coins" % Global.format_number(Global.upg5cost)
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
	$s/ui/upg6.disabled = true


func _on_upg_7_pressed() -> void:
	if Global.currency < Global.upg7cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg7cost
	Global.upg7cost = int(ceil(Global.upg7cost * 1.15))
	Global.attack_bonus += 20
	Global.save_game()
	$s/ui/upg7/upg7cost.text = "%s Coins" % Global.format_number(Global.upg7cost)
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
	$s/ui/upg8.disabled = true


func _on_upg_9_pressed() -> void:
	if Global.currency < Global.upg9cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg9cost
	Global.upg9cost = int(ceil(Global.upg9cost * 1.15))
	Global.attack_bonus += 100
	Global.save_game()
	$s/ui/upg9/upg9cost.text = "%s Coins" % Global.format_number(Global.upg9cost)
	message_label.text = "You gained 100 attack strength"


func _on_upg_10_pressed() -> void:
	Global.wfire_bought = true
	
	if Global.currency < Global.upg10cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg10cost
	if "wraithfire_spell" not in Global.inventory:
		Global.inventory.append("wraithfire_spell")
	Global.save_game()
	message_label.text = "You gained a new spell"
	$s/ui/upg10.disabled = true


func _on_upg_11_pressed() -> void:
	Global.lootupg1_bought = true
	
	if Global.currency < Global.upg11cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg11cost
	Global.coin_bonus_mul *= 1.2
	Global.xp_bonus_mul *= 1.2
	Global.save_game()
	message_label.text = "Coins and xp gain increased by 20%"
	
	$s/ui/upg11.disabled = true


func _on_upg_12_pressed() -> void:
	if Global.currency < Global.upg12cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg12cost
	Global.upg12cost = int(ceil(Global.upg12cost * 1.15))
	Global.attack_bonus += 500
	Global.save_game()
	$s/ui/upg12/upg12cost.text = "%s Coins" % Global.format_number(Global.upg12cost)
	message_label.text = "You gained 500 attack strength"


func _on_upg_13_pressed() -> void:
	Global.cquake_bought = true
	
	if Global.currency < Global.upg13cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg13cost
	if "cosmicquake_spell" not in Global.inventory:
		Global.inventory.append("cosmicquake_spell")
	Global.save_game()
	message_label.text = "You gained a new spell"
	$s/ui/upg13.disabled = true


func _on_upg_14_pressed() -> void:
	Global.lootupg2_bought = true
	
	if Global.currency < Global.upg14cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg14cost
	Global.coin_bonus_mul *= 1.33
	Global.xp_bonus_mul *= 1.33
	Global.save_game()
	message_label.text = "Coins and xp gain increased by 30%"
	
	$s/ui/upg14.disabled = true
