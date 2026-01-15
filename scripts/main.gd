extends Control

@onready var message_label = $ui/message
@onready var health_bar = $ui/HealthBar

func _ready():
	randomize()
	start_new_battle()
	update_ui()
	
func start_new_battle():
	Global.enemy_defeated = false
	Global.phase = Global.game_phase.FIGHTING
	Global.current_enemy = create_boss() if is_boss_level() else create_random_enemy()
	message_label.text = "An enemy appears, its a wild %s" % Global.current_enemy.name
func is_boss_level():
	return Global.level % 10 == 0
	
func create_random_enemy():
	return {
		"name": "Goblin",
		"health": 30 + Global.level * 12,
		"attack": 6 + Global.level * 3,
		"is_boss": false,
	}
func create_boss():
	return {
		"name": "Dragon",
		"health": 30 + Global.level * 12*2,
		"attack": 6 + Global.level * 3*1.5,
		"is_boss": true,
	}

func _on_attack_pressed() -> void:
	if Global.phase == Global.game_phase.GAME_OVER:
		return
	if Global.enemy_defeated:
		start_new_battle()
		update_ui()
		return
	player_attack()
	update_ui()
func player_attack():
	var dmg = Global.base_attack + Global.attack_bonus
	Global.current_enemy.health -= dmg
	message_label.text = "You dealt %d damage." % dmg
	if Global.current_enemy.health <= 0:
		win_battle()
	else:
		enemy_attack()
func enemy_attack():
	var dmg = Global.current_enemy.attack
	Global.health -= dmg
	message_label.text = "It hits you for %d, it has %s health left" % [dmg,Global.current_enemy.health]
	if Global.health <= 0:
		game_over()
func win_battle():
	Global.enemy_defeated = true
	Global.phase = Global.game_phase.VICTORY
	var coins_gain = 10 + Global.level * 2
	var xp_gain = 20 + Global.level * 5
	if Global.current_enemy.is_boss:
		coins_gain *= 2
		xp_gain *= 2
	Global.currency += coins_gain
	Global.xp += xp_gain
	
	message_label.text =  "Enemy defeated! +%d coins, +%d XP" % [coins_gain, xp_gain]
	check_level_up()

func check_level_up():
	while Global.xp >= Global.xp_needed:
		Global.xp -= Global.xp_needed
		Global.level += 1
		Global.xp_needed = int(Global.xp_needed * 1.25)

		Global.max_health += 10
		Global.base_attack += 2
		Global.health = Global.max_health

		message_label.text += " Level Up!"
func update_ui():
	$ui/stats/level.text = "Level: %d" % Global.level
	$ui/stats/currency.text = "Coins: %d" % Global.currency
	$ui/stats/astrength.text = "Attack: %d" % (Global.base_attack+Global.attack_bonus)
	$ui/health.text = "Health: %d" % Global.health
	health_bar.max_value = Global.max_health
	health_bar.value = max(Global.health,0)
	$ui/HBoxContainer/castspell.visible = has_spell()
	
func has_spell():
	for item in Global.inventory:
		if item.contains("Spell"):
			return true
	return false
func game_over():
	Global.phase = Global.game_phase.GAME_OVER
	Global.health = 0
	message_label.text = "You were defeated. Game Over"
	
