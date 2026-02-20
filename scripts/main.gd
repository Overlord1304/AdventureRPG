extends Control
@onready var dialogue_box = $Control
@onready var message_label = $s/ui/message
@onready var health_bar = $s/ui/HealthBar
@export var spell_group: ButtonGroup
var health_tween
var displayed_health = 0
var intro = [
	{"name":"???","text":"Welcome to AdventureRPG. Face different enemies to level up and increase attack power,so you can face better enemies lol. Click attack to fight your first enemy!"}
]
var mv_intro_dialogue = [
	{"name":"???","text":"sup twin"},
	{"name":"???","text":"im in a bit of a tight situation right now, can you lend me a small sum of,uhhh, 1,000,000 coins?"},
	{"name":"???","text":"oh yea i didnt introduce myself. you can call me like...."},
	{"name":"???","text":"uhhh.... yea you can call me like mike or something"},
	{"name":"mike void","text":"yea that sounds like a good name lets go with that"},
	{"q":"blahblahfiller","name":"mike void","text":"Give 1,000,000 coins?"},
	{"name":"mike void","text":"grr your gonna pay for this"},
	{"name":"mike void","text":"muahahhahahaha"}
]
var mv_defeat_dialogue = [
	{"name":"mike void","text":"AAAAAAAAAAAAAAAAAAAAA"}
]
var mv_last_dialogue = [
	{"name":"mike void","text":"ILL BE BACK JUST YOU WAIT"}
]
var enemies = [
	{
		"name": "Goblin",
		"min_level": 1,
		"max_level": 4,
		"health_mul": 1.0,
		"attack_mul": 1.0,
		"coin_mul": 1.0,
		"xp_mul": 1.0
	},
	{
		"name": "Bandit",
		"min_level": 1,
		"max_level": 4,
		"health_mul": 0.8,
		"attack_mul": 1.3,
		"coin_mul": 1.0,
		"xp_mul":1.0
	},
	{  
		"name": "Orc",
		"min_level": 3,
		"max_level": 8,
		"health_mul": 1.4,
		"attack_mul": 1.3,
		"coin_mul": 1.2,
		"xp_mul": 1.3
	},
	{
		"name": "Vulture",
		"min_level": 3,
		"max_level": 8,
		"health_mul": 1.3,
		"attack_mul": 1.5,
		"coin_mul": 1.3,
		"xp_mul": 1.4
	},
	{
		"name": "Skeleton",
		"min_level": 7,
		"max_level": 14,
		"health_mul": 1.2,
		"attack_mul": 1.8,
		"coin_mul": 1.5,
		"xp_mul": 1.6
	},
	{
		"name": "Slime",
		"min_level": 7,
		"max_level": 14,
		"health_mul": 1.5,
		"attack_mul": 1.5,
		"coin_mul": 1.6,
		"xp_mul": 1.6
	},
	{
		"name": "Mech",
		"min_level": 11,
		"max_level": 19,
		"health_mul": 2.0,
		"attack_mul": 1.7,
		"coin_mul": 1.9,
		"xp_mul": 2.1
	},
	{
		"name": "Shaman",
		"min_level": 11,
		"max_level": 19,
		"health_mul": 2.0,
		"attack_mul": 1.8,
		"coin_mul": 2.0,
		"xp_mul": 2.1
	}, 
	{
		"name": "Armored Skeleton",
		"min_level": 18,
		"max_level": 25,
		"health_mul": 2.4,
		"attack_mul": 3.0,
		"coin_mul": 4.0,
		"xp_mul": 4.1
	},
	{
		"name": "Wraith",
		"min_level": 18,
		"max_level": 25,
		"health_mul": 2.4,
		"attack_mul": 3.0,
		"coin_mul": 4.0,
		"xp_mul": 4.1
	},
	{
		"name": "Ogre",
		"min_level": 26,
		"max_level": 30,
		"health_mul": 5.0,
		"attack_mul": 3.2,
		"coin_mul": 5.5,
		"xp_mul": 4.3
	},
	{
		"name": "Golem",
		"min_level": 26,
		"max_level": 30,
		"health_mul": 5.1,
		"attack_mul": 3.1,
		"coin_mul": 5.5,
		"xp_mul": 4.2
	},
	{
		"name": "Demon",
		"min_level": 31,
		"max_level": 99,
		"health_mul": 9.5,
		"attack_mul": 4.5,
		"coin_mul": 10,
		"xp_mul": 9.0
	},
	{
		"name": "Imp",
		"min_level": 31,
		"max_level": 99,
		"health_mul": 9.5,
		"attack_mul": 4.5,
		"coin_mul": 10.0,
		"xp_mul": 9.0
	}
]

var bosses = [
	{
		"name": "Goblin Lord",
		"min_level": 5,
		"max_level": 14,
		"health_mul": 1.5,
		"attack_mul": 1.6,
		"coin_mul": 2.0,
		"xp_mul": 2.0
	},
	{
		"name": "SKELLY",
		"min_level": 15,
		"max_level": 20,
		"health_mul": 1.7,
		"attack_mul": 2.5,
		"coin_mul": 3.0,
		"xp_mul": 3.5
	},
	{
		"name": "M.E.C.H",
		"min_level": 21,
		"max_level": 25,
		"health_mul": 4.0,
		"attack_mul": 3.5,
		"coin_mul": 9.0,
		"xp_mul": 7.5
	},
	{
		"name": "SKELLY V2",
		"min_level": 26,
		"max_level": 30,
		"health_mul": 6.0,
		"attack_mul": 4.0,
		"coin_mul": 12.0,
		"xp_mul": 8.5
	},
	{
		"name": "overlord",
		"min_level": 31,
		"max_level": 99,
		"health_mul": 10.0,
		"attack_mul": 7.5,
		"coin_mul": 20.0,
		"xp_mul": 20.0
	}
]
func _ready():
	Global.load_game()
	if !Global.has_seen_dialogue:
		dialogue_box.start_dialogue(intro)
		Global.has_seen_dialogue = true
		Global.save_game()
	$bgmusic.play()
	$s/ui/message.hide()
	if Global.mv_seen:
		mv_tp_in()
	if Global.mv_defeated:
		$michaelvoid.hide()
	randomize()
	_connect_buttons(self)
	displayed_health = Global.health
	health_bar.value = Global.health
	if Global.sbol:
		start_new_battle()
	if Global.fball_bought:
		$s/ui/spellselect/container/fireball.show()
	if Global.iblast_bought:
		$s/ui/spellselect/container/iceblast.show()
	if Global.bos_bought:
		$s/ui/spellselect/container/baneofskeletons.show()
	if Global.discharge_bought:
		$s/ui/spellselect/container/discharge.show()
	if Global.wfire_bought:
		$s/ui/spellselect/container/wraithfire.show()
	if Global.cquake_bought:
		$s/ui/spellselect/container/cosmicquake.show()
	if Global.hfire_bought:
		$s/ui/spellselect/container/hellfire.show()
	
	update_ui()
func _process(delta):
	if Global.spell_selected == "":
		$s/ui/HBoxContainer/castspell.disabled = true
	else:
		$s/ui/HBoxContainer/castspell.disabled = false
	if has_spell() and !Global.mv_seen:
		Global.mv_seen = true
		Global.save_game()
		mv_intro()

	
	
func start_new_battle():

	Global.enemy_defeated = false
	Global.phase = Global.game_phase.FIGHTING
	Global.sutf = false
	Global.current_enemy = create_boss() if is_boss_level() else create_random_enemy()
	$s/ui/message.show()
	for b in spell_group.get_buttons():
		b.button_pressed = false
	message_label.text = "An enemy appears, its a wild %s" % Global.current_enemy["name"]
func is_boss_level():
	if Global.level < 5:
		return false
	return randi() % 5 == 0
	
func create_random_enemy():
	var enemy_list = pick(enemies)
	return {
		"name": enemy_list["name"],
		"health": int(ceil((30 + Global.level * 12) * enemy_list["health_mul"])),
		"attack": int(ceil((6 + Global.level * 3) * enemy_list["attack_mul"])),
		"coin_mul": enemy_list["coin_mul"],
		"xp_mul": enemy_list["xp_mul"],
		"is_boss": false,
	}
func create_boss():
	var boss_list = pick(bosses)
	return {
		"name": boss_list["name"],
		"health": int(ceil((30 + Global.level * 12) * boss_list["health_mul"])),
		"attack": int(ceil((6 + Global.level * 3) * boss_list["attack_mul"])),
		"coin_mul": boss_list["coin_mul"],
		"xp_mul": boss_list["xp_mul"],
		"is_boss": true,
	}

func _on_attack_pressed() -> void:
	if Global.current_enemy == null:
		start_new_battle()
		return
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

	Global.current_enemy["health"] -= dmg
	message_label.text = "You dealt %s damage." % Global.format_number(dmg)
	if Global.current_enemy["health"] <= 0:
		win_battle()
	else:
		enemy_attack()
func enemy_attack():
	var dmg = Global.current_enemy["attack"]
	if Global.mv_attack:
		dmg *= 3
	Global.health -= dmg
	message_label.text = "It hits you for %s, it has %s health left" % [Global.format_number(dmg),Global.format_number(Global.current_enemy["health"])]
	if Global.health <= 0:
		game_over()
func win_battle():
	if Global.mv_attack:
		Global.mv_attack = false
		mv_defeat() 
		Global.save_game() 
	Global.enemy_defeated = true
	Global.phase = Global.game_phase.VICTORY
	var base_coins_gain = 10 + Global.level * 2
	var base_xp_gain = 20 + Global.level * 5
	var coins_gain = int(base_coins_gain * Global.current_enemy["coin_mul"]* Global.coin_bonus_mul)
	var xp_gain = int(base_xp_gain * Global.current_enemy["xp_mul"] * Global.xp_bonus_mul)

	Global.currency += coins_gain
	Global.xp += xp_gain
	
	message_label.text =  "Enemy defeated! +%s coins, +%s XP" % [Global.format_number(coins_gain), Global.format_number(xp_gain)]
	check_level_up()
	Global.save_game()
func check_level_up():
	while Global.xp >= Global.xp_needed:
		Global.xp -= Global.xp_needed
		Global.level += 1
		Global.xp_needed = int(Global.xp_needed * 1.4)

		Global.max_health += 25
		Global.base_attack += 2
		Global.health = Global.max_health
 
		message_label.text += " Level Up!"
		Global.save_game()
func update_ui():
	$s/ui/stats/level.text = "Level %s: (%s/%s XP)" % [Global.format_number(Global.level),Global.format_number(Global.xp),Global.format_number(Global.xp_needed)] 
	$s/ui/stats/currency.text = "Coins: %s" % Global.format_number(Global.currency)
	$s/ui/stats/astrength.text = "Attack: %s" % Global.format_number((Global.base_attack+Global.attack_bonus))
	$s/ui/health.text = "Health: %s" % Global.format_number(Global.health)
	health_bar.max_value = Global.max_health
	animate_hb(Global.health)
	if Global.mv_attack:
		health_bar.self_modulate = Color("171717")
	else:
		health_bar.self_modulate = Color("fe6f61")
	$s/ui/HBoxContainer/castspell.visible = has_spell()
	$s/ui/HBoxContainer/heal.disabled = (
		Global.phase == Global.game_phase.FIGHTING
		and not Global.enemy_defeated
	)
func has_spell():
	for item in Global.inventory:
		if item.contains("spell"):
			return true
	return false
func game_over():
	Global.phase = Global.game_phase.GAME_OVER
	Global.health = 0
	message_label.text = "You were defeated. Game Over"
	$s/ui/HBoxContainer.hide()
	$s/ui/spellselect.hide()
	$s/ui/Restart.show()
	Global.reset_game()
	update_ui()


func _on_heal_pressed() -> void:
	if Global.phase == Global.game_phase.GAME_OVER:
		return
	if Global.health >= Global.max_health:
		message_label.text = "Your health is already full."
		return
	Global.health = Global.max_health
	message_label.text = "You healed back to full health."
	update_ui()
	Global.save_game()
func animate_hb(new_health):
	new_health = clamp(new_health,0,Global.max_health)
	if health_tween and health_tween.is_running():
		health_tween.kill()
	health_tween = create_tween()
	health_tween.set_trans(Tween.TRANS_QUAD)
	health_tween.set_ease(Tween.EASE_OUT)
	health_tween.tween_property(
		health_bar,
		"value",
		new_health,
		0.3
	)
	displayed_health = new_health


func _on_shop_pressed() -> void:
	if Global.phase == Global.game_phase.FIGHTING and not Global.enemy_defeated:
		message_label.text = "You cant open the shop while in a fight"
		return
	Global.sbol = false
	get_tree().change_scene_to_file("res://scenes/shop.tscn")
func select_spell(spell_name):
	Global.spell_selected = spell_name
	message_label.text = "Selected spell"
	

func _on_fireball_pressed() -> void:
	select_spell("fireball_spell")
func cast_spell():
	if Global.phase != Global.game_phase.FIGHTING:
		message_label.text = "You can't cast a spell now."
		return
	if Global.enemy_defeated or Global.current_enemy == null:
		message_label.text = "You can't cast a spell now."
		return
	if Global.sutf:
		message_label.text = "Spell already used once in this fight!"
		return
	var dmg = 0
	match Global.spell_selected:
		"fireball_spell":
			dmg = 40
		"iceblast_spell":
			dmg = 75
		"bos_spell":
			dmg = 200
		"discharge_spell":
			dmg = 400
		"wraithfire_spell":
			dmg = 800
		"cosmicquake_spell":
			dmg = 1500
		"hellfire_spell":
			dmg = 3000
	Global.current_enemy["health"] -= dmg
	message_label.text = "You cast %s for %s damage" %[Global.spell_selected,Global.format_number(dmg)]
	Global.sutf = true
	for b in spell_group.get_buttons():
		b.button_pressed = false
	Global.spell_selected = ""

	if Global.current_enemy["health"] <= 0:
		win_battle()
	else:
		enemy_attack()
	update_ui()

func _on_castspell_pressed() -> void:
	cast_spell()


func _on_iceblast_pressed() -> void:
	select_spell("iceblast_spell")
func pick(p):
	var candidates = []
	for e in p:
		if Global.level >= e.min_level and Global.level <= e.max_level:
			candidates.append(e)

	return candidates.pick_random()
 
 
func _on_baneofskeletons_pressed() -> void:
	select_spell("bos_spell")


func _on_discharge_pressed() -> void:
	select_spell("discharge_spell")


func _on_restart_pressed() -> void:
	Global.reset_game()
	get_tree().reload_current_scene()


func _on_wraithfire_pressed() -> void:
	select_spell("wraithfire_spell")


func _on_cosmicquake_pressed() -> void:
	select_spell("cosmicquake_spell")


func _on_hellfire_pressed() -> void:
	select_spell("hellfire_spell")

func _connect_buttons(node):
	if node is Button or node is TextureButton:
		node.button_down.connect(play_click)

	for child in node.get_children():
		_connect_buttons(child)
		
func play_click():
	$clicksound.play()
func mv_intro():
	$michaelvoid.show()
	$michaelvoid/michaelvoidanim.play("tp_in")
	await $michaelvoid/michaelvoidanim.animation_finished
	$michaelvoid/michaelvoidanim.play("idle")
	dialogue_box.start_dialogue(mv_intro_dialogue)
	await dialogue_box.dialogue_finished
	$michaelvoid/michaelvoidanim.play("tp_out")
	await $michaelvoid/michaelvoidanim.animation_finished
	$michaelvoid.hide()
	message_label.text = "You feel your heart turn black with void"
	message_label.show()
	update_ui()
func mv_tp_in():
	$michaelvoid.show()
	$michaelvoid/michaelvoidanim.play("tp_in")
	await $michaelvoid/michaelvoidanim.animation_finished
	$michaelvoid/michaelvoidanim.play("idle")
func mv_defeat():
	Global.mv_defeated = true
	$michaelvoid.show()
	$michaelvoid/michaelvoidanim.play("defeat")
	dialogue_box.start_dialogue(mv_defeat_dialogue)
	await dialogue_box.dialogue_finished
	dialogue_box.start_dialogue(mv_last_dialogue)
	await dialogue_box.dialogue_finished
	$michaelvoid/michaelvoidanim.play("tp_out2") 
	await $michaelvoid/michaelvoidanim.animation_finished
	$michaelvoid.hide()
	


func _on_dungeon_pressed():
	get_tree().change_scene_to_file("res://scenes/dungeon.tscn")
