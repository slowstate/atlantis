class_name MiningTool
extends Item

@onready var collectable: Collectable = $Collectable


func _init() -> void:
	id = Ids.Items.MiningTool


func _on_interactable_just_interacted() -> void:
	collectable.collect()
	queue_free()
