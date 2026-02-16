extends Control
class_name DialogueBox
@onready var name_label = $Panel/name
@onready var dialogue_text = $Panel/dialogue
@onready var next_button = $Panel/button

var dialogue = []
var index = 0

var typing_speed = 0.03
var is_typing = false
var full_text = ""

func start_dialogue(lines):
	dialogue = lines
	index = 0
	show()
	show_line()

func show_line():
	if index >= dialogue.size():
		hide()
		return
	name_label.text = dialogue[index]["name"]
	full_text = dialogue[index]["text"]
	dialogue_text.text = ""
	is_typing = true

	await _type_text(full_text)

	is_typing = false

func _type_text(text):
	for i in text.length():
		if not is_typing:
			return
		dialogue_text.text += text[i]
		await get_tree().create_timer(typing_speed).timeout

	dialogue_text.text = text

func _on_button_pressed() -> void:
	if is_typing:

		is_typing = false
		dialogue_text.text = full_text
	else:
		index += 1
		show_line()
