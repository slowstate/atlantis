class_name MiningTool
extends Entity

@onready var collectable: Collectable = $Collectable


func _init() -> void:
	id = Ids.Entities.MiningTool


func _on_interactable_just_interacted() -> void:
	collectable.collect()
	queue_free()
