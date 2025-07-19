extends MarginContainer

@export var grid : GridContainer
@export var items : Array[ItemButton]

func _ready() -> void:
	InventoryManager.connect_with_inventory(self)

func give_focus(neighbor : Control) -> void:
	var first : bool = true
	var visible_count : int = 0
	for i in range(items.size()):
		if items[i].visible:
			visible_count += 1
			if first:
				items[i].give_focus()
				first = false
			if visible_count % 2 == 1:
				items[i].give_focus_neighbor(neighbor)

func unlock_item(index : int) -> void:
	items[index].visible = true

func _on_item_button_container_used() -> void:
	print("BANANA")
