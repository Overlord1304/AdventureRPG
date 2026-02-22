extends Control

func _ready():
	$michaelvoid/michaelvoidanim.play("idle")

func _on_keygame_pressed():
	if Global.currency >= 5:
		get_tree().change_scene_to_file("res://scenes/keygame.tscn")
		Global.currency -= 5
		Global.save_game()


func _on_close_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_whackamolegame_pressed() -> void:
	if Global.currency >= 10:
		get_tree().change_scene_to_file("res://scenes/whackamolegame.tscn")
		Global.currency -= 10
		Global.save_game()
