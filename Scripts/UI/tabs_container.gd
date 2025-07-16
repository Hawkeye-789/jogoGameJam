extends MarginContainer

var idx := 3

func _on_inv_button_pressed() -> void:
	pass

func _on_settings_button_pressed() -> void:
	InventoryManager.add_item(idx)
	idx -= 1

func _on_save_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	pass # Replace with function body.
