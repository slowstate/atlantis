class_name SpawnPoint
extends Node

static var string_name = &"SpawnPoint"


func _enter_tree() -> void:
	owner.set_meta(string_name, self)


func _exit_tree() -> void:
	if owner != null:
		owner.remove_meta(string_name)


func get_global_position() -> Vector2:
	return (owner as Node2D).global_position
