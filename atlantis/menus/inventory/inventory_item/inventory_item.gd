class_name InventoryItem
extends Button

signal inventory_item_selected(inventory_item: InventoryItem)

var id: Ids.Entities
var count: int

@onready var count_label: Label = $CountLabel


func _ready() -> void:
	icon = Icons.icon_by_entity_id[id]
	count_label.text = str(count) if count > 1 else ""


func _on_pressed() -> void:
	inventory_item_selected.emit(self)
