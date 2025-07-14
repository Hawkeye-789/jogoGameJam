extends Control

class_name DialogueBox

@export var display_timer : Timer
@export var safeguard_timer : Timer
@export var text_label : Label
@export var options_buttons : Array[Button]
@export var skip_arrow : Sprite2D

var letter_idx : int = 0
var text : String = ""
var current_dialogue : Dialogue

var letter_display_timer := 0.04
var space_display_timer := 0.02
var punctuation_display_timer := 0.01
var current_display_speed_multiplier : float = 1
var option_safeguard : bool = false
var wait_for_input : bool = false
var displaying : bool = false
var interrupted : bool = false

signal display_ended
signal option_chosen(number : int)
signal page_skipped

func _process(delta: float) -> void:
	if wait_for_input:
		if Input.is_action_just_pressed("interact"):
			text_label.text = ""
			page_skipped.emit()
			wait_for_input = false
			interrupted = false
			skip_arrow.visible = false
	
	if displaying:
		if Input.is_action_just_pressed('interact'):
			interrupted = true

func set_dialogue(dialogue : Dialogue) -> void:
	current_dialogue = dialogue
	display_dialogue()

func display_dialogue() -> void:
	visible = true
	for i in range(current_dialogue.pages.size()):
		option_safeguard = false
		if (i >= current_dialogue.pages.size() - 1) and !current_dialogue.options.is_empty():
			option_safeguard = true
		set_text(current_dialogue.pages[i])
		await display_ended
		if option_safeguard == true:
			set_options(current_dialogue.options)
		await page_skipped
	visible = false

func set_text(page : Page) -> void:
	text = page.text
	current_display_speed_multiplier = page.letter_display_multiplier
	display_text()
	set_deferred("displaying", true)

func end_page_display() -> void:
	displaying = false
	display_ended.emit()
	letter_idx = 0
	if option_safeguard == true:
		safeguard_timer.start()
	else:
		wait_for_input = true
		skip_arrow.visible = true

func show_all_text() -> void:
	var rest_of_text : String = text.substr(letter_idx)
	text_label.text += rest_of_text
	end_page_display()

func display_text() -> void:
	if interrupted:
		interrupted = false
		show_all_text()
		return
	text_label.text += text[letter_idx]
	letter_idx += 1
	
	if letter_idx >= text.length():
		end_page_display()
		return
	
	match text[letter_idx]:
		"!", "?", ",", ".":
			display_timer.start(punctuation_display_timer * current_display_speed_multiplier)
		" ":
			display_timer.start(space_display_timer * current_display_speed_multiplier)
		_:
			display_timer.start(letter_display_timer * current_display_speed_multiplier)

func choose_option(option_number : int) -> void:
	for button in options_buttons:
		button.visible = false
		button.text = ""
	option_chosen.emit(option_number)

func set_options(options_labels : Array[String]) -> void:
	for i in range(options_labels.size()):
		options_buttons[i].visible = true
		options_buttons[i].text = options_labels[i]
		options_buttons[i].pressed.connect(choose_option.bind(i))
	await safeguard_timer.timeout
	options_buttons[0].grab_focus()

func _on_timer_timeout() -> void:
	display_text()

func _on_safeguard_timer_timeout() -> void:
	wait_for_input = true
