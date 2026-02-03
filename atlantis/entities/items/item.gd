class_name Item
extends Node2D

var id: Ids.Items


func _enter_tree() -> void:
	assert(id != null, "Error: Item ID is null. ID must be added to ids.gd and assigned in the class _init")
	z_index = 5
