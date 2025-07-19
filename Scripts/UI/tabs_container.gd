extends MarginContainer

@export var settings_menu : MarginContainer
@export var inventory : MarginContainer
@export var save_menu : MarginContainer

@export var inv_button : Button
@export var settings_button : Button
@export var save_button : Button
@export var quit_button : Button

func _on_inv_button_pressed() -> void:
	save_menu.visible = false
	settings_menu.visible = false
	inventory.visible = true
	inventory.give_focus(inv_button)

func _on_settings_button_pressed() -> void:
	inventory.visible = false
	save_menu.visible = false
	settings_menu.visible = true
	settings_menu.give_focus(settings_button)

func _on_save_button_pressed() -> void:
	inventory.visible = false
	settings_menu.visible = false
	save_menu.visible = true
	save_menu.give_focus()

func _on_quit_button_pressed() -> void:
	pass # Replace with function body.
