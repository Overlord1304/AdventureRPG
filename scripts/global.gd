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
var fball_bought = false
var iblast_bought = false
var bos_bought = false
var discharge_bought = false
var upg1cost = 15
var upg2cost = 30
var upg3cost = 40
var upg4cost = 100
var upg5cost = 80
var upg6cost = 220
var upg7cost = 160
var upg8cost = 750
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
		"inventory": inventory,
		"fball_bought": fball_bought,
		"upg1cost": upg1cost,
		"upg2cost": upg2cost,
		"upg3cost": upg3cost,
		"upg4cost": upg4cost,
		"iblast_bought": iblast_bought,
		"upg5cost": upg5cost,
		"upg6cost": upg6cost,
		"bos_bought": bos_bought,
		"upg7cost": upg7cost,
		"upg8cost": upg8cost,
		"discharge_bought": discharge_bought,
		}
	var file = FileAccess.open(saves,FileAccess.WRITE)
	file.store_var(data)
	file.close()
func load_game():
	if FileAccess.file_exists(saves):
		var file = FileAccess.open(saves,FileAccess.READ)
		var data = file.get_var()
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			health = data.get("health",100)
			max_health = data.get("max_health",100)
			currency = data.get("currency",0)
			base_attack = data.get("base_attack",10)
			attack_bonus = data.get("attack_bonus",0)
			level = data.get("level",1)
			xp = data.get("xp",0)
			xp_needed = data.get("xp_needed",50)
			inventory = data.get("inventory",[])
			fball_bought = data.get("fball_bought",false)
			upg1cost = data.get("upg1cost",15)
			upg2cost = data.get("upg2cost",30)
			upg3cost = data.get("upg3cost",40)
			upg4cost = data.get("upg4cost",100)
			iblast_bought = data.get("iblast_bought",false)
			upg5cost = data.get("upg5cost",80)
			upg6cost = data.get("upg6cost",220)
			bos_bought = data.get("bos_bought",false)
			upg7cost = data.get("upg7cost",160)
			upg8cost = data.get("upg8cost",750)
			discharge_bought = data.get("discharge_bought",false)
	else:
		save_game()


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
	fball_bought = false
	iblast_bought = false
	bos_bought = false
	discharge_bought = false
	inventory.clear()
	upg1cost = 15
	upg2cost = 30
	upg3cost = 40
	upg4cost = 100
	upg5cost = 80
	upg6cost = 220
	upg7cost = 160
	upg8cost = 750
	bos_bought = false
	phase = game_phase.FIGHTING
	DirAccess.remove_absolute(saves)
