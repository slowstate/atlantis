class_name Inventory
extends Control

const INVENTORY_ITEM = preload("uid://dr650y141ls7y")
const INVENTORY_NOTE = preload("uid://bpt3so4d8palv")

var items: Dictionary[Ids.Entities, int] = { }
var notes: Array[Ids.Notes]

@onready var inventory_grid: GridContainer = $VBoxContainer/InventoryGrid


func add_item(entity_id: Ids.Entities) -> void:
	items.get_or_add(entity_id, 0)
	items[entity_id] += 1
	update_user_interface()


func remove_item(entity_id: Ids.Entities) -> void:
	if has_item(entity_id):
		items[entity_id] -= 1
	if items.get(entity_id) <= 0:
		items.erase(entity_id)
	update_user_interface()


func has_item(entity_id: Ids.Entities) -> bool:
	return items.has(entity_id)


func get_item_count(entity_id: Ids.Entities) -> int:
	return items.get(entity_id)


func add_note(note_id: Ids.Notes) -> void:
	var index := notes.bsearch(note_id)
	notes.insert(note_id, index)
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

	#for note in notes:
	#var inventory_note: InventoryNote = INVENTORY_NOTE.instantiate()
	#inventory_note.id = note.id
	#inventory_note.text = note.title
