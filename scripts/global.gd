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
