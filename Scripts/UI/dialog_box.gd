extends Control

class_name DialogueBox

@export var display_timer : Timer
@export var text_label : Label

var letter_idx : int = 0
var text : String = ""

@export var letter_display_timer := 0.07
@export var space_display_timer := 0.05
@export var punctuation_display_timer := 0.02
var current_display_speed_multiplier : float = 1

signal page_ended

func set_text(page : Page) -> void:
	text = page.text
	current_display_speed_multiplier = page.letter_display_multiplier
	display_text()

func display_text() -> void:
	text_label.text += text[letter_idx]
	letter_idx += 1
	
	if letter_idx >= text.length():
		page_ended.emit()
		return
	
	match text[letter_idx]:
		"!", "?", ",", ".":
			display_timer.start(punctuation_display_timer * current_display_speed_multiplier)
		" ":
			display_timer.start(space_display_timer * current_display_speed_multiplier)
		_:
			display_timer.start(letter_display_timer * current_display_speed_multiplier)

func _on_timer_timeout() -> void:
	display_text()
