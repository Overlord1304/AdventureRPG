extends Node
enum game_phase {FIGHTING,VICTORY,GAME_OVER}
var phase = game_phase.FIGHTING
var health = 100
var max_health = 100 
var currency = 0
var base_attack = 10
var level = 1
var xp = 0
var xp_needed = 50
var attack_bonus = 0
var current_enemy = {}
var enemy_defeated = false
var inventory = []
var saves = "user://saves.save"
var sbol = true #startbattleonload
var spell_selected = ""
var sutf = false #spellusedthisfight

func save_game():
	var data = {
		"health": health,
		"max_health": max_health,
		"currency": currency,
		"base_attack": base_attack,
		"attack_bonus": attack_bonus,
		"level": level,
		"xp": xp,
		"xp_needed": xp_needed,
		"inventory": inventory
	}
	var file = FileAccess.open(saves,FileAccess.WRITE)
	file.store_var(data)
	file.close()
func load_game():
	if not FileAccess.file_exists(saves):
		return false
	var file = FileAccess.open(saves,FileAccess.READ)
	var data = file.get_var()
	file.close()
	health = data.health
	max_health = data.max_health
	currency = data.currency
	base_attack = data.base_attack
	attack_bonus = data.attack_bonus
	level = data.level
	xp = data.xp
	xp_needed = data.xp_needed
	inventory = data.inventory
	return true

func reset_game():
	health = 100
	max_health = 100 
	currency = 0
	base_attack = 10
	level = 1
	xp = 0
	xp_needed = 50
	attack_bonus = 0
	enemy_defeated = false
	inventory.clear()
	phase = game_phase.FIGHTING
	DirAccess.remove_absolute(saves)
