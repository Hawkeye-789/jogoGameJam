extends CanvasLayer

class_name DialogueLayer

@onready var dialogue_box : DialogueBox = $DialogueBox as DialogueBox

func set_dialogue(dialogue : Dialogue) -> void:
	dialogue_box.start(dialogue)

signal option_chosen(number : int)

func _on_dialogue_box_option_chosen(number: int) -> void:
	option_chosen.emit(number)
