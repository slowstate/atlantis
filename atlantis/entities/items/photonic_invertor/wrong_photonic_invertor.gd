class_name WrongPhotonicInvertor
extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $InteractionBox/CollisionShape2D


func enable_collision(enable: bool) -> void:
	collision_shape_2d.disabled = !enable
