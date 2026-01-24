extends Node2D

const WAREHOUSE_INTERIOR = preload("uid://bod07y12hlqh")


func _on_interactable_just_interacted() -> void:
	get_tree().change_scene_to_packed(WAREHOUSE_INTERIOR)
