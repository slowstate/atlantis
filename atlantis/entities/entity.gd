class_name Entity
extends Node2D

var id: Ids.Entities


func _enter_tree() -> void:
	assert(id != null, "Error: Entity ID is null. ID must be added to ids.gd and assigned in the class _init")
