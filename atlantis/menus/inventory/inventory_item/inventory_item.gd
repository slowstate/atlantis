class_name InventoryItem
extends PanelContainer

var icon_texture: Texture2D
var count: int

@onready var icon: TextureRect = $Icon
@onready var count_label: Label = $CountLabel


func _ready() -> void:
	icon.texture = icon_texture
	count_label.text = str(count) if count > 1 else ""
