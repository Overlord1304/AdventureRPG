extends Node2D

@onready var keys := []
var key_positions := []
var correct_key_index := -1
var shuffling := false

func _ready():
	randomize()
	for child in get_children():
		if child is Area2D:
			keys.append(child)
			key_positions.append(child.position)
			child.input_event.connect(func(viewport, event, shape_idx):
				_on_key_pressed(viewport, event, shape_idx, child)
			)

func _on_shuffle_pressed():
	if shuffling:
		return
	start_game()
	

func start_game():
	if shuffling:
		return
	shuffling = true
	await get_tree().create_timer(0.5).timeout
	flash_key()

func flash_key():
	correct_key_index = randi() % keys.size()
	var key = keys[correct_key_index]
	var sprite = key.get_node_or_null("Sprite2D")
	
	if sprite:
		var original_modulate = sprite.modulate
		sprite.modulate = Color(0, 1, 0)
		await get_tree().create_timer(1.0).timeout
		sprite.modulate = original_modulate
	
	await get_tree().create_timer(0.5).timeout
	start_shuffle()

func start_shuffle():
	var shuffle_times = 20
	for i in range(shuffle_times):
		await shuffle_round()
	shuffling = false

func shuffle_round():
	var a = randi() % keys.size()
	var b = randi() % keys.size()
	while b == a:
		b = randi() % keys.size()
	var key_a = keys[a]
	var key_b = keys[b]
	var pos_a = key_positions[a]
	var pos_b = key_positions[b]
	var mid = (pos_a + pos_b) / 2
	var offset = Vector2(0, -80)   
	var tween = create_tween()
	tween.set_parallel(true)


	tween.tween_method(
		func(t):
			key_a.position = pos_a.bezier_interpolate(mid + offset, mid + offset, pos_b, t),
		0.0, 1.0, 0.25
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


	tween.tween_method(
		func(t):
			key_b.position = pos_b.bezier_interpolate(mid - offset, mid - offset, pos_a, t),
		0.0, 1.0, 0.25
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	key_positions[a] = pos_b
	key_positions[b] = pos_a
func _on_key_pressed(viewport, event, shape_idx, key):
	if shuffling:
		return
	
	if event is InputEventMouseButton and event.pressed:
		var index = keys.find(key)
		if index == correct_key_index:
			Global.reward_rarity = "common"
			get_tree().change_scene_to_file("res://scenes/rewardscreen.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/dungeon.tscn")
