extends Sprite2D


func _ready() -> void:
	visible = false


func _on_inventory_show_notification() -> void:
	visible = true
