class_name Radio
extends Sprite2D


func _on_interactable_just_interacted() -> void:
	Dialogue.create("Radio message")
