class_name PhotonicInvertor
extends Item

@onready var collectable: Collectable = $Collectable
@onready var collision_shape_2d: CollisionShape2D = $InteractionBox/CollisionShape2D


func _init() -> void:
	id = Ids.Items.PhotonicInvertor


func enable_collision(enable: bool) -> void:
	collision_shape_2d.disabled = !enable


func _on_interactable_just_interacted() -> void:
	collectable.collect()
	queue_free()
