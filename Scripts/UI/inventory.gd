extends MarginContainer

@export var grid : GridContainer
@export var items : Array[ItemButton]

func _ready() -> void:
	InventoryManager.connect_with_inventory(self)

func get_focus() -> void:
	for item in items:
		if item.visible:
			item.grab_focus()
			return

func unlock_item(index : int) -> void:
	items[index].visible = true

func _on_item_button_container_used() -> void:
	print("BANANA")
