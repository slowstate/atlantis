class_name InventoryNote
extends Button

signal inventory_note_selected(inventory_note: InventoryNote)

var id: Ids.Notes
var title: String:
	get():
		return NoteStrings.note_titles[id]
var content: String:
	get():
		return NoteStrings.note_content[id]


func _ready() -> void:
	icon = Icons.icon_by_note_id[id]


func _on_pressed() -> void:
	inventory_note_selected.emit(self)
