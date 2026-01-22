class_name Entity
extends Node2D

static var id: Ids.Entities


func _enter_tree() -> void:
	assert(id != null, "Error: Entity ID is null. ID must be added to ids.gd and assigned in the class _init")


func get_component(component: StringName) -> Node:
	return get_meta(component, null)


func has_component(component: StringName) -> bool:
	return has_meta(component)
