extends Node2D

@onready var keys := []
var key_positions = []
var correct_key_index = -1
var shuffling = false

func _ready():
	# Collect ONLY Area2D keys
	for child in get_children():
		if child is Area2D:
			keys.append(child)
			key_positions.append(child.position)
			child.connect("input_event", Callable(self, "_on_key_pressed").bind(child))

	# Do NOT start automatically
	# Wait for button press


func _on_shuffle_pressed():
	start_game()


func start_game():
	await get_tree().create_timer(1.0).timeout
	flash_key()


func flash_key():
	correct_key_index = randi() % keys.size()
	var key = keys[correct_key_index]

	var sprite = key.get_node("Sprite2D")
	var original_modulate = sprite.modulate
	sprite.modulate = Color(0, 1, 0)

	await get_tree().create_timer(1.0).timeout
	sprite.modulate = original_modulate

	await get_tree().create_timer(1.5).timeout
	start_shuffle()


func start_shuffle():
	shuffling = true
	var shuffle_times = 40

	for i in range(shuffle_times):
		shuffle_keys()
		await get_tree().create_timer(0.15).timeout

	shuffling = false


func shuffle_keys():
	var shuffled = key_positions.duplicate()
	shuffled.shuffle()

	for i in range(keys.size()):
		var tween = create_tween()
		tween.tween_property(keys[i], "position", shuffled[i], 0.15).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func _on_key_pressed(viewport, event, shape_idx, key):
	if shuffling:
		print("hi")
		return
	
	if event is InputEventMouseButton and event.pressed:
		var index = keys.find(key)

		if index == correct_key_index:
			print("Correct key!")
		else:
			print("Wrong key!")
