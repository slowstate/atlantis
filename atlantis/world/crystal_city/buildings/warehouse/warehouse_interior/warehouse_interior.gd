class_name WarehouseInterior
extends Node2D

signal warehouse_interior_door_just_interacted

@onready var background: Sprite2D = $Background
@onready var top_boundary_collision_shape_2d: CollisionShape2D = $TopBoundary/TopBoundaryCollisionShape2D
@onready var right_boundary_collision_shape_2d: CollisionShape2D = $RightBoundary/RightBoundaryCollisionShape2D
@onready var bottom_boundary_collision_shape_2d: CollisionShape2D = $BottomBoundary/BottomBoundaryCollisionShape2D
@onready var left_boundary_collision_shape_2d: CollisionShape2D = $LeftBoundary/LeftBoundaryCollisionShape2D
@onready var warehouse_generator: WarehouseGenerator = $WarehouseGenerator
@onready var wrong_photonic_invertor_1: WrongPhotonicInvertor = $WrongPhotonicInvertor1
@onready var wrong_photonic_invertor_2: WrongPhotonicInvertor = $WrongPhotonicInvertor2
@onready var wrong_photonic_invertor_3: WrongPhotonicInvertor = $WrongPhotonicInvertor3
@onready var wrong_photonic_invertor_4: WrongPhotonicInvertor = $WrongPhotonicInvertor4
@onready var wrong_photonic_invertor_5: WrongPhotonicInvertor = $WrongPhotonicInvertor5


func _ready() -> void:
	background.visible = true
	top_boundary_collision_shape_2d.disabled = true
	right_boundary_collision_shape_2d.disabled = true
	bottom_boundary_collision_shape_2d.disabled = true
	left_boundary_collision_shape_2d.disabled = true
	warehouse_generator.enable_collision(false)
	wrong_photonic_invertor_1.enable_collision(false)
	wrong_photonic_invertor_2.enable_collision(false)
	wrong_photonic_invertor_3.enable_collision(false)
	wrong_photonic_invertor_4.enable_collision(false)
	wrong_photonic_invertor_5.enable_collision(false)


func enable_collision(enable: bool) -> void:
	top_boundary_collision_shape_2d.disabled = !enable
	right_boundary_collision_shape_2d.disabled = !enable
	bottom_boundary_collision_shape_2d.disabled = !enable
	left_boundary_collision_shape_2d.disabled = !enable
	warehouse_generator.enable_collision(enable)
	wrong_photonic_invertor_1.enable_collision(enable)
	wrong_photonic_invertor_2.enable_collision(enable)
	wrong_photonic_invertor_3.enable_collision(enable)
	wrong_photonic_invertor_4.enable_collision(enable)
	wrong_photonic_invertor_5.enable_collision(enable)


func _on_interactable_just_interacted() -> void:
	SfxManager.play_sfx("OpenDoor", 0, -20, -15, 0.9, 1.1)
	warehouse_interior_door_just_interacted.emit()
