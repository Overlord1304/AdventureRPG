extends Control
func _ready() -> void:
	randomize()
	select_reward()
var common_rewards = [
	{"type":"coins","amount":10},
	{"type":"spell","name":"Bloodbath"},
	{"type":"attack_power","amount":5}
]
var rare_rewards = [
	{"type":"coins","amount":30},
	{"type":"spell","name":"Tidal Wave"},
	{"type":"attack_power","amount":10},
	{"type":"buff","amount":1.5}
]
func select_reward():
	var rarity = Global.reward_rarity
	if rarity == "common":
		var num = randi() % 3
		var reward = common_rewards[num]
		if reward.type == "coins":
			Global.currency += reward.amount
			Global.save_game()
			$s/ui/message.text = "You got: %d coins." % reward.amount
		elif reward.type == "spell":
			Global.bbath_bought = true
			if "bloodbath_spell" not in Global.inventory:
				Global.inventory.append("bloodbath_spell")
			Global.save_game()
			$s/ui/message.text = "You received the %s spell." % reward.name
			
		elif reward.type == "attack_power":
			$s/ui/message.text = "You got an attack power increase of %d." % reward.amount
			Global.attack_bonus += reward.amount
			Global.save_game()
	if Global.reward_rarity == "rare":
		var num = randi() % 4
		var reward = rare_rewards[num]
		if reward.type == "coins":
			Global.currency += reward.amount
			Global.save_game()
			$s/ui/message.text = "You got: %d coins." % reward.amount
		elif reward.type == "spell":
			Global.twave_bought = true
			if "tidalwave_spell" not in Global.inventory:
				Global.inventory.append("tidalwave_spell")
			Global.save_game()
			$s/ui/message.text = "You received the %s spell." % reward.name
			
		elif reward.type == "attack_power":
			$s/ui/message.text = "You got an attack power increase of %d." % reward.amount
			Global.attack_bonus += reward.amount
			Global.save_game()
		elif reward.type == "buff":
			$s/ui/message.text = "You got a %dx coins boost for 5 minues." % reward.amount
			Global.coin_bonus_mul *= 1.5
			Global.save_game()  
func _on_close_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
