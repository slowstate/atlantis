class_name CrystalCity
extends Node2D

@onready var warehouse: Warehouse = $Warehouse
@onready var warehouse_interior: WarehouseInterior = $WarehouseInterior


func _ready() -> void:
	warehouse_interior.visible = false


func set_all_children_visible(set_children_visible: bool) -> void:
	for child in get_children():
		child.visible = set_children_visible


func _on_warehouse_warehouse_door_just_interacted() -> void:
	set_all_children_visible(false)
	warehouse_interior.visible = true


func _on_warehouse_interior_warehouse_interior_door_just_interacted() -> void:
	set_all_children_visible(true)
	warehouse_interior.visible = false
