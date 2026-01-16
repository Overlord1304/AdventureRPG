extends Control
@onready var message_label = $ui/message
@onready var close = $close

func _ready():
	message_label.text = "Welcome to the shop!"
	if Global.fball_bought:
		$ui/upg2.disabled = true
	if Global.iblast_bought:
		$ui/upg4.disabled = true
	$ui/upg1/upg1cost.text = "%d Coins" % Global.upg1cost
	$ui/upg2/upg2cost.text = "%d Coins" % Global.upg2cost
	$ui/upg3/upg3cost.text = "%d Coins" % Global.upg3cost
	$ui/upg4/upg4cost.text = "%d Coins" % Global.upg4cost
	if Global.level >= 5:
		$ui/upg3/Lvl5Overlay.hide()
		$ui/upg4/Lvl5Overlay.hide()
func _on_upg_1_pressed() -> void:
	if Global.currency < Global.upg1cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg1cost
	Global.upg1cost = int(ceil(Global.upg1cost * 1.15))
	Global.attack_bonus += 2
	Global.save_game()
	$ui/upg1/upg1cost.text = "%d Coins" % Global.upg1cost
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
		$ui/upg2.disabled = true


func _on_upg_3_pressed() -> void:
	if Global.currency < Global.upg3cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= Global.upg3cost
	Global.upg3cost = int(ceil(Global.upg3cost * 1.15))
	Global.attack_bonus += 5
	Global.save_game()
	$ui/upg3/upg3cost.text = "%d Coins" % Global.upg3cost
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
		$ui/upg4.disabled = true
