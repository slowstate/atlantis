class_name Glowstone
extends Entity

var mined := false

@onready var collectable: Collectable = $Collectable


func _init() -> void:
	id = Ids.Entities.Glowstone


func _physics_process(_delta: float) -> void:
	if mined:
		collectable.collect()
		queue_free()


func _on_interactable_just_interacted() -> void:
	if Globals.player.inventory.has_item(Ids.Entities.MiningTool):
		mined = true
