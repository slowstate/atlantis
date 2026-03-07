class_name Warehouse
extends Node2D

signal warehouse_door_just_interacted

var is_lit := false

@onready var warehouse_skylight: Sprite2D = $WarehouseSkylight
@onready var warehouse_light_argo: Sprite2D = $WarehouseLightArgo
@onready var warehouse_light: Sprite2D = $WarehouseLight
@onready var light_up_point: Node2D = $LightUpPoint


func _physics_process(_delta: float) -> void:
	if !Globals.argo:
		return
	if Globals.is_crystal_city_generator_enabled:
		is_lit = true
		warehouse_skylight.modulate.a = 1.0
		warehouse_light.visible = true
		return
	var distance_x = clamp(abs(Globals.argo.global_position.x - light_up_point.global_position.x), 60.0, 180.0)
	if distance_x > 180.0:
		is_lit = false
		return
	var distance_y = clamp(abs(Globals.argo.global_position.y - light_up_point.global_position.y), 20.0, 40.0)
	if distance_y > 40.0:
		is_lit = false
		return
	is_lit = true
	var warehouse_lights_alpha_y = clamp(remap(distance_y, 20.0, 40.0, 1.0, 0.0), 0.0, 1.0)
	var warehouse_lights_alpha_x = clamp(remap(distance_x, 60.0, 180.0, 1.0, 0.0), 0.0, 1.0)
	warehouse_skylight.modulate.a = warehouse_lights_alpha_y * warehouse_lights_alpha_x
	warehouse_light_argo.modulate.a = warehouse_lights_alpha_y * warehouse_lights_alpha_x


func _on_interactable_just_interacted() -> void:
	if is_lit:
		warehouse_door_just_interacted.emit()
