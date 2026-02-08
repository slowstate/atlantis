class_name WarehouseInterior
extends Node2D

signal warehouse_interior_door_just_interacted

@onready var top_boundary_collision_shape_2d: CollisionShape2D = $TopBoundary/TopBoundaryCollisionShape2D
@onready var right_boundary_collision_shape_2d: CollisionShape2D = $RightBoundary/RightBoundaryCollisionShape2D
@onready var bottom_boundary_collision_shape_2d: CollisionShape2D = $BottomBoundary/BottomBoundaryCollisionShape2D
@onready var left_boundary_collision_shape_2d: CollisionShape2D = $LeftBoundary/LeftBoundaryCollisionShape2D


func _ready() -> void:
	top_boundary_collision_shape_2d.disabled = true
	right_boundary_collision_shape_2d.disabled = true
	bottom_boundary_collision_shape_2d.disabled = true
	left_boundary_collision_shape_2d.disabled = true


func enable_boundaries(enable: bool) -> void:
	top_boundary_collision_shape_2d.disabled = !enable
	right_boundary_collision_shape_2d.disabled = !enable
	bottom_boundary_collision_shape_2d.disabled = !enable
	left_boundary_collision_shape_2d.disabled = !enable


func _on_interactable_just_interacted() -> void:
	warehouse_interior_door_just_interacted.emit()
