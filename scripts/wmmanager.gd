extends GridContainer

@onready var holes = []
var active_hole = null
var score = 0
var time_left = 60
var game_running = true

func _ready() -> void:
	for child in get_children():
		if child is Button:
			holes.append(child)
			child.pressed.connect(_on_button_pressed.bind(child))
	start_timer()
	start_game()

func start_timer():
	while time_left > 0:
		await get_tree().create_timer(1.0).timeout
		time_left -= 1
		$"../timer".text = "Time: %d" % time_left
	end_game()

func start_game():
	while game_running:
		await spawn_mole()
		await get_tree().create_timer(0.5).timeout

func spawn_mole():
	if not game_running:
		return
	if active_hole:
		var old_sprite = active_hole.get_node("AnimatedSprite2D")
		old_sprite.play("default")
		active_hole = null
	var hole = holes[randi() % holes.size()]
	active_hole = hole
	var sprite = hole.get_node("AnimatedSprite2D")
	sprite.play("mole")
	await get_tree().create_timer(0.7).timeout
	if active_hole == hole and game_running:
		sprite.play("default")
		active_hole = null

func _on_button_pressed(hole):
	if not game_running:
		return
	if hole == active_hole:
		score += 20 
		$"../score".text = "Score: %d/35" % score
		if score>=35:
			Global.reward_rarity = "rare"
			get_tree().change_scene_to_file("res://scenes/rewardscreen.tscn")
		var sprite = hole.get_node("AnimatedSprite2D")
		sprite.play("default")
		active_hole = null


func end_game():
	game_running = false
	if active_hole:
		var sprite = active_hole.get_node("AnimatedSprite2D")
		sprite.play("default")
		active_hole = null
	get_tree().change_scene_to_file("res://scenes/dungeon.tscn")
