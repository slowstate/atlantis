class_name Inventory
extends Control

const INVENTORY_ITEM = preload("uid://dr650y141ls7y")

var items: Dictionary = { }

@onready var inventory_grid: GridContainer = $PanelContainer/InventoryGrid


func add_item(entity: Entity) -> void:
	items.get_or_add(entity.id, 0)
	items[entity.id] += 1
	update_user_interface()


func update_user_interface() -> void:
	for inventory_item in inventory_grid.get_children():
		inventory_grid.remove_child(inventory_item)
		inventory_item.queue_free()

	for item in items.keys():
		var inventory_item: InventoryItem = INVENTORY_ITEM.instantiate()
		inventory_item.icon_texture = Icons.IconByEntityId[item]
		inventory_item.count = items[item]
		inventory_grid.add_child(inventory_item)
