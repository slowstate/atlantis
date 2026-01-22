class_name Interactable
extends Node

signal just_interacted

@export var interaction_box: Area2D

static var string_name = &"Interactable"

func _enter_tree() -> void:
	owner.set_meta(string_name, self)

func _exit_tree() -> void:
	if owner != null:
		owner.remove_meta(string_name)

func interact() -> Variant:
	just_interacted.emit()
	return owner
