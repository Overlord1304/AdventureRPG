extends Control
func _ready() -> void:
	randomize()
	select_reward()
var common_rewards = [
	{"type":"coins","amount":10},
	{"type":"spell","name":"bloodbath"},
	{"type":"attack_power","amount":5}
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
			Global.save_game()
			$s/ui/message.text = "You received the %s spell." % reward.name
		elif reward.type == "attack_power":
			$s/ui/message.text = "You got an attack power increase of %d." % reward.amount
			Global.attack_bonus += reward.amount
			Global.save_game()
