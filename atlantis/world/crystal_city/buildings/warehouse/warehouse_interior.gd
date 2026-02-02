class_name WarehouseInterior
extends Node2D

signal warehouse_interior_door_just_interacted


func _on_interactable_just_interacted() -> void:
	warehouse_interior_door_just_interacted.emit()
