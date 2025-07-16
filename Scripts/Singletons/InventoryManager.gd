extends Node

var inv : Control

func connect_with_inventory(inventory : Control) -> void:
	inv = inventory

func add_item(index : int) -> void:
	inv.unlock_item(index)
