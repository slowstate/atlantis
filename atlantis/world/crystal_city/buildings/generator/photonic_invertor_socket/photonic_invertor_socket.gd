class_name PhotonicInvertorSocket
extends Node2D

signal photonic_invertor_just_interacted


func _on_interactable_just_interacted() -> void:
	photonic_invertor_just_interacted.emit()
