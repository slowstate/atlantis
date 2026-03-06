class_name Warehouse
extends Node2D

signal warehouse_door_just_interacted

var is_lit := false

@onready var warehouse_skylight: Sprite2D = $WarehouseSkylight
@onready var warehouse_light_argo: Sprite2D = $WarehouseLightArgo


func _on_interactable_just_interacted() -> void:
	if is_lit:
		warehouse_door_just_interacted.emit()


func _on_light_up_box_body_entered(_body: Node2D) -> void:
	is_lit = true
	warehouse_skylight.visible = true
	warehouse_light_argo.visible = true


func _on_light_up_box_body_exited(_body: Node2D) -> void:
	is_lit = false
	warehouse_skylight.visible = false
	warehouse_light_argo.visible = false


func _on_light_up_box_2_body_entered(_body: Node2D) -> void:
	is_lit = true
	warehouse_skylight.visible = true
	warehouse_light_argo.visible = true


func _on_light_up_box_2_body_exited(_body: Node2D) -> void:
	is_lit = false
	warehouse_skylight.visible = false
	warehouse_light_argo.visible = false
