extends Node2D

@export var dialogue_box : DialogueBox
@export var dialogue_box2 : DialogueBox
@export var pagina : Page
@export var pagina2 : Page

func _ready() -> void:
	dialogue_box.set_text(pagina)
	dialogue_box2.set_text(pagina2)
