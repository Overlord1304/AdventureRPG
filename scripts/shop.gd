extends Control
@onready var message_label = $ui/message
@onready var upg1 = $ui/upg1
@onready var close = $close

func _ready():
	message_label.text = "Welcome to the shop!"

func _on_upg_1_pressed() -> void:
	var cost = 15
	if Global.currency < cost:
		message_label.text = "Not enough coins!"
		return
	Global.currency -= cost
	Global.attack_bonus += 2
	Global.save_game()
	message_label.text = "You gained 2 attack strength"


func _on_close_pressed() -> void:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
