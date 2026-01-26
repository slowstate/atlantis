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
	icon = Icons.IconByNoteId[id]


func _on_pressed() -> void:
	inventory_note_selected.emit(self)
