extends Node2D

@export var dialogue_box : DialogueBox
@export var dialogo : Dialogue

func _ready() -> void:
	dialogue_box.option_chosen.connect(print_option)
	dialogue_box.set_dialogue(dialogo)

func print_option(option_number : int) -> void:
	print(option_number)
