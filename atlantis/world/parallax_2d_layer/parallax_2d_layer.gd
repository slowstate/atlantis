class_name Parallax2DLayer
extends Parallax2D

@export var scale_start_position: bool = true


func _ready() -> void:
	scroll_offset.x *= scroll_scale.x
	scroll_offset.y *= scroll_scale.y
