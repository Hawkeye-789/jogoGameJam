extends MarginContainer

@export var grid : GridContainer

func get_focus() -> void:
	grid.get_children()[0].grab_focus()

func _on_item_button_container_used() -> void:
	print("BANANA")
