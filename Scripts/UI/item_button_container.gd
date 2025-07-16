extends MarginContainer

@export var button : Button
@export var opening_dialogue : Dialogue
@export var use_dialogue : Dialogue

signal used

func _on_item_button_pressed() -> void:
	button.release_focus()
	TheDialogueLayer.set_dialogue(opening_dialogue)
	TheDialogueLayer.option_chosen.connect(item_option_chosen)

func item_option_chosen(number : int) -> void:
	TheDialogueLayer.option_chosen.disconnect(item_option_chosen)
	if number == 0:
		TheDialogueLayer.set_dialogue(use_dialogue)
		await TheDialogueLayer.dialogue_box.dialogue_ended
		TheDialogueLayer.dialogue_box._end_dialogue()
		used.emit()
	else:
		TheDialogueLayer.dialogue_box._end_dialogue()
	await get_tree().process_frame
	button.grab_focus()
