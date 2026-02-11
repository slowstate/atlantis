class_name InventoryItem
extends Button

signal inventory_item_selected(inventory_item: InventoryItem)

var id: Ids.Items
var count: int
var item_name: String:
	get():
		return ItemStrings.item_names[id]
var description: String:
	get():
		return ItemStrings.item_descriptions[id]
var viewed := false

@onready var count_label: Label = $CountLabel
@onready var item_notification: Sprite2D = $ItemNotification


func _ready() -> void:
	icon = Icons.icon_by_item_id[id]
	count_label.text = str(count) if count > 1 else ""
	item_notification.visible = !viewed


func _on_pressed() -> void:
	inventory_item_selected.emit(self)
	viewed = true
	item_notification.visible = !viewed
