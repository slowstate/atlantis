class_name Inventory
extends Control

const INVENTORY_ITEM = preload("uid://dr650y141ls7y")
const INVENTORY_NOTE = preload("uid://bpt3so4d8palv")

var items: Dictionary[Ids.Entities, int] = { }
var notes: Array[Ids.Notes]

@onready var items_grid: GridContainer = $Items/VBoxContainer/ItemsGrid
@onready var notes_grid: GridContainer = $Items/VBoxContainer/NotesGrid
@onready var title_label: Label = $TextureRect/Info/TitleLabel
@onready var content_label: Label = $TextureRect/Info/ContentLabel


func _ready() -> void:
	items_grid.visible = true
	notes_grid.visible = false
	_clear_info_text()


func add_item(entity_id: Ids.Entities, count: int = 1) -> void:
	items.get_or_add(entity_id, 0)
	items[entity_id] += count
	update_user_interface()


func remove_item(entity_id: Ids.Entities, count: int = 1) -> void:
	if has_item(entity_id):
		items[entity_id] -= count
	if items.get(entity_id) <= 0:
		items.erase(entity_id)
	update_user_interface()


func has_item(entity_id: Ids.Entities) -> bool:
	return items.has(entity_id)


func get_item_count(entity_id: Ids.Entities) -> int:
	return items.get(entity_id)


func add_note(note_id: Ids.Notes) -> void:
	var index := notes.bsearch(note_id)
	notes.insert(index, note_id)
	update_user_interface()


func has_note(note_id: Ids.Notes) -> bool:
	return notes.has(note_id)


func update_user_interface() -> void:
	for inventory_item in items_grid.get_children():
		items_grid.remove_child(inventory_item)
		inventory_item.queue_free()

	for item_id in items.keys():
		var inventory_item: InventoryItem = INVENTORY_ITEM.instantiate()
		inventory_item.id = item_id
		inventory_item.count = items[item_id]
		inventory_item.inventory_item_selected.connect(_on_inventory_item_selected)
		items_grid.add_child(inventory_item)

	for inventory_note in notes_grid.get_children():
		notes_grid.remove_child(inventory_note)
		inventory_note.queue_free()

	for note_id in notes:
		var inventory_note: InventoryNote = INVENTORY_NOTE.instantiate()
		inventory_note.id = note_id
		inventory_note.inventory_note_selected.connect(_on_inventory_note_selected)
		notes_grid.add_child(inventory_note)


func _on_inventory_item_selected(inventory_item: InventoryItem) -> void:
	title_label.text = "Inventory Item " + str(inventory_item.id)
	content_label.text = "Inventory item description"


func _on_inventory_note_selected(inventory_note: InventoryNote) -> void:
	title_label.text = inventory_note.title
	content_label.text = inventory_note.content


func _on_items_button_pressed() -> void:
	items_grid.visible = true
	notes_grid.visible = false
	_clear_info_text()


func _on_notes_button_pressed() -> void:
	items_grid.visible = false
	notes_grid.visible = true
	_clear_info_text()


func _clear_info_text() -> void:
	title_label.text = ""
	content_label.text = ""
