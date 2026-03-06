class_name PhotonicInvertor
extends Item

@onready var collectable: Collectable = $Collectable


func _init() -> void:
	id = Ids.Items.PhotonicInvertor


func _on_interactable_just_interacted() -> void:
	collectable.collect()
	SfxManager.play_sfx("CollectInverter",0,-20,-15,0.9,1.1)
	queue_free()
