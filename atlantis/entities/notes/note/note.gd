class_name Note
extends Sprite2D

@export var id: Ids.Notes

@onready var collectable: Collectable = $Collectable


func _enter_tree() -> void:
	assert(id != null, "Error: Note ID is null. ID must be added to ids.gd and assigned in the UI")


func get_component(component: StringName) -> Node:
	return get_meta(component, null)


func has_component(component: StringName) -> bool:
	return has_meta(component)


func _on_interactable_just_interacted() -> void:
	collectable.collect()
	queue_free()
