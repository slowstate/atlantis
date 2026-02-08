class_name Warehouse
extends Node2D

signal warehouse_door_just_interacted

var is_lit := false


func _on_interactable_just_interacted() -> void:
	if is_lit:
		warehouse_door_just_interacted.emit()


func _on_light_up_box_body_entered(_body: Node2D) -> void:
	is_lit = true


func _on_light_up_box_body_exited(_body: Node2D) -> void:
	is_lit = false
