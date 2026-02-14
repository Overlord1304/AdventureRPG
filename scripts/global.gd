extends Node
enum game_phase {FIGHTING,VICTORY,GAME_OVER}
var phase = game_phase.FIGHTING
var health = 100
var max_health = 100 
var currency = 0
var base_attack = 10
var level = 1
var xp = 0
var coin_bonus_mul = 1
var xp_bonus_mul = 1
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
var wfire_bought = false
var cquake_bought = false
var hfire_bought = false
var lootupg1_bought = false
var lootupg2_bought = false
var lootupg3_bought = false
var upg1cost = 15
var upg2cost = 30
var upg3cost = 40
var upg4cost = 100
var upg5cost = 80
var upg6cost = 220
var upg7cost = 160
var upg8cost = 750
var upg9cost = 800
var upg10cost = 2000
var upg11cost = 3000
var upg12cost = 10000
var upg13cost = 15000
var upg14cost = 12000
var upg15cost = 25000
var upg16cost = 50000
var upg17cost = 30000
var has_seen_dialogue = false
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
			"upg9cost": upg9cost,
			"discharge_bought": discharge_bought,
			"upg10cost": upg10cost,
			"wfire_bought": wfire_bought,
			"upg11cost": upg11cost,
			"lootupg1_bought": lootupg1_bought,
			"coin_bonus_mul": coin_bonus_mul,
			"xp_bonus_mul": xp_bonus_mul,
			"upg12cost" : upg12cost,
			"upg13cost" : upg12cost,
			"cquake_bought" : cquake_bought,
			"upg14cost": upg14cost,
			"lootupg2cost" : lootupg2_bought,
			"upg15cost": upg15cost,
			"upg16cost": upg16cost,
			"hfire_bought": hfire_bought,
			"upg17cost": upg17cost,
			"lootupg3cost": lootupg3_bought,
			"has_seen_dialogue": has_seen_dialogue
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
			upg9cost = data.get("upg9cost",800)
			discharge_bought = data.get("discharge_bought",false)
			upg10cost = data.get("upg10cost",2000)
			wfire_bought = data.get("wfire_bought",false)
			upg11cost = data.get("upg11cost",3000)
			lootupg1_bought = data.get("lootupg1_bought",false)
			coin_bonus_mul = data.get("coin_bonus_mul",1)
			xp_bonus_mul = data.get("xp_bonus_mul",1)
			upg12cost = data.get("upg12cost",10000)
			upg13cost = data.get("upg13cost",15000)
			cquake_bought = data.get("cquake_bought",false)
			upg14cost = data.get("upg14cost",12000)
			lootupg2_bought = data.get("lootupg2_bought",false)
			upg15cost = data.get("upg15cost",25000)
			upg16cost = data.get("upg16cost",50000)
			hfire_bought = data.get("hfire_bought",false)
			upg17cost = data.get("upg17cost",30000)
			lootupg3_bought = data.get("lootupg3_bought",false)
			has_seen_dialogue = data.get("has_seen_dialogue",false)
	else:
		save_game()


func reset_game():
	current_enemy = null
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
	wfire_bought = false
	cquake_bought = false
	hfire_bought = false
	lootupg1_bought = false
	lootupg2_bought = false
	lootupg3_bought = false
	inventory.clear()
	upg1cost = 15
	upg2cost = 30
	upg3cost = 40
	upg4cost = 100
	upg5cost = 80
	upg6cost = 220
	upg7cost = 160
	upg8cost = 750
	upg9cost = 800
	upg10cost = 2000
	upg11cost = 3000
	upg12cost = 10000
	upg13cost = 15000
	upg14cost = 12000
	upg15cost = 25000
	upg16cost = 50000
	upg17cost = 30000
	coin_bonus_mul = 1
	xp_bonus_mul = 1
	phase = game_phase.FIGHTING
	save_game()
func format_number(n):
	if n < 1000:
		return str(int(round(n)))
	var suffixes = ["", "K", "M", "B", "T", "Q"]
	var tier = int(floor(log(n) / log(1000)))
	tier = min(tier, suffixes.size() - 1)
	var scaled = n / pow(1000, tier)
	var text = ""
	if scaled < 10:
		text = str(round(scaled * 10) / 10.0)
	else:
		text = str(int(round(scaled)))
	return text + suffixes[tier]
