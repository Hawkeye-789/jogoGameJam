extends Control
class_name DialogueBox

@export var text_label: Label
@export var skip_arrow: Sprite2D
@export var display_timer: Timer
@export var safeguard_timer: Timer
@export var buttons: Array[Button]

var dialogue: Dialogue
var current_page_idx := 0
var char_idx := 0
var displaying := false
var interrupted := false
var active := false


signal option_selected(index: int)
signal dialogue_ended

func _ready() -> void:
	for i in buttons.size():
		buttons[i].pressed.connect(_on_button_pressed.bind(i))

func start(data: Dialogue) -> void:
	active = true
	visible = true
	dialogue = data
	current_page_idx = 0
	_show_page()

func _show_page():
	text_label.text = ""
	char_idx = 0
	displaying = true
	skip_arrow.visible = false
	_display_next_char()

func _display_next_char():
	if interrupted:
		_show_all_text()
		return

	var page: Page = dialogue.pages[current_page_idx]
	if char_idx < page.text.length():
		text_label.text += page.text[char_idx].replace("\\n", "\n")
		char_idx += 1

		var character = page.text[char_idx - 1]
		var delay : float
		match character:
			" ", "\n": 
				delay = 0.02
			".", ",", "!", "?": 
				delay = 0.1
			_: 
				delay = 0.04

		display_timer.start(delay * page.letter_display_multiplier)
	else:
		_on_page_done()

func _on_page_done():
	displaying = false
	if current_page_idx == dialogue.pages.size() - 1 and dialogue.options.size() > 0:
		_show_options()
	else:
		skip_arrow.visible = true

func _show_all_text():
	var page: Page = dialogue.pages[current_page_idx]
	text_label.text = page.text.replace("\\n", "\n")
	displaying = false
	interrupted = false
	_on_page_done()

func _input(event):
	if !active:
		return
	
	var can_skip : bool = dialogue.options.is_empty() or current_page_idx != dialogue.pages.size() - 1
	if displaying and event.is_action_pressed("interact"):
		interrupted = true
	elif not displaying and event.is_action_pressed("interact") and can_skip:
		_next_page()

func _next_page():
	current_page_idx += 1
	if current_page_idx >= dialogue.pages.size():
		_end_dialogue()
	else:
		_show_page()

func _end_dialogue():
	visible = false
	active = false
	dialogue_ended.emit()

func _show_options():
	for i in dialogue.options.size():
		buttons[i].visible = true
		buttons[i].text = dialogue.options[i]
	safeguard_timer.start()
	await safeguard_timer.timeout
	buttons[0].grab_focus()

func _on_button_pressed(i: int):
	for b in buttons:
		b.visible = false
		b.text = ""
	option_selected.emit(i)

func _on_display_timer_timeout():
	_display_next_char()
