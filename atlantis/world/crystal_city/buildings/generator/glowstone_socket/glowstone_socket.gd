extends Node2D

signal glowstone_just_interacted


func _on_interactable_just_interacted() -> void:
	glowstone_just_interacted.emit()
