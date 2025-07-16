extends Node2D

@export var dialogue_box : DialogueBox
@export var dialogo : Dialogue

func _ready() -> void:
	TheDialogueLayer.dialogue_box.option_selected.connect(print_option)
	TheDialogueLayer.set_dialogue(dialogo)

func print_option(option_number : int) -> void:
	print(option_number)
