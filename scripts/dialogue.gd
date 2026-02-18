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
signal dialogue_finished
func start_dialogue(lines):
	dialogue = lines
	index = 0
	show()
	show_line()

func show_line():
	if index >= dialogue.size():
		hide()
		emit_signal("dialogue_finished")
		return
	name_label.text = dialogue[index]["name"]
	full_text = dialogue[index]["text"]
	if dialogue[index].has("q"):
		$Panel/no.show()
	else:
		$Panel/no.hide()
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
		if dialogue[index].has("q"):
			pass
		else:
			index += 1
			show_line()


func _on_no_pressed() -> void:
	index += 1
	show_line()
	Global.mv_attack = true
