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
var content_texture: Texture2D
var viewed := false

@onready var note_notification: Sprite2D = $NoteNotification


func _ready() -> void:
	icon = Icons.icon_by_note_id[id]
	note_notification.visible = !viewed
	if id == Ids.Notes.ArkPlans:
		content_texture = preload("uid://cehefnc6eql3c")


func _on_pressed() -> void:
	inventory_note_selected.emit(self)
	viewed = true
	note_notification.visible = !viewed
