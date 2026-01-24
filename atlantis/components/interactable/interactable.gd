class_name Interactable
extends Node

signal just_interacted

static var string_name = &"Interactable"

@export var interaction_box: Area2D


func _enter_tree() -> void:
	owner.set_meta(string_name, self)
	assert(interaction_box != null, "Error: Interaction Box is not set in " + str(owner))
	interaction_box.set_collision_layer_value(1, false)
	interaction_box.set_collision_layer_value(4, true)
	interaction_box.set_collision_mask_value(1, true)


func _exit_tree() -> void:
	if owner != null:
		owner.remove_meta(string_name)


func interact() -> Variant:
	just_interacted.emit()
	return owner
