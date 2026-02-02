class_name Note
extends Sprite2D

@export var id: Ids.Notes

@onready var collectable: Collectable = $Collectable


func _enter_tree() -> void:
	assert(id != null, "Error: Note ID is null. ID must be added to ids.gd and assigned in the UI")


func _on_interactable_just_interacted() -> void:
	collectable.collect()
	queue_free()
