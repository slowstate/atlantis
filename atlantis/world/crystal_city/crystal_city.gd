class_name CrystalCity
extends Node2D

var city_lights: Array[Sprite2D] = []

@onready var warehouse: Warehouse = $Warehouse
@onready var warehouse_interior: WarehouseInterior = $WarehouseInterior
@onready var city_lights_timer: Timer = $CityLightsTimer
@onready var city_lights_8: Sprite2D = $CityParallaxBack/CityLights8
@onready var city_lights_13: Sprite2D = $CityParallaxBack/CityLights13
@onready var city_lights_1: Sprite2D = $CityParallaxFront/CityLights1
@onready var city_lights_5: Sprite2D = $CityParallaxFront/CityLights5
@onready var city_lights_10: Sprite2D = $CityParallaxFront/CityLights10
@onready var city_lights_2: Sprite2D = $CityParallaxFront/CityLights2
@onready var city_lights_3: Sprite2D = $CityParallaxFront/CityLights3
@onready var city_lights_9: Sprite2D = $CityParallaxFront/CityLights9
@onready var city_lights_4: Sprite2D = $CityParallaxFront/CityLights4
@onready var city_lights_6: Sprite2D = $CityParallaxFront/CityLights6
@onready var city_lights_7: Sprite2D = $CityParallaxFront/CityLights7
@onready var city_lights_11: Sprite2D = $CityParallaxFront/CityLights11
@onready var city_lights_12: Sprite2D = $CityParallaxFront/CityLights12
@onready var city_lights_14: Sprite2D = $CityParallaxFront/CityLights14
@onready var city_lights_15: Sprite2D = $CityParallaxFront/CityLights15
@onready var street_lamp_lights: Node2D = $StreetLampLights


func _ready() -> void:
	warehouse_interior.visible = false
	street_lamp_lights.visible = false
	SignalBus.player_respawned.connect(_on_player_respawned)
	city_lights = [
		city_lights_1,
		city_lights_2,
		city_lights_3,
		city_lights_4,
		city_lights_5,
		city_lights_6,
		city_lights_7,
		city_lights_8,
		city_lights_9,
		city_lights_10,
		city_lights_12,
		city_lights_13,
		city_lights_11,
		city_lights_14,
		city_lights_15,
	]
	set_city_lights_visible(Globals.is_crystal_city_generator_enabled)


func set_all_children_visible(set_visibility: bool) -> void:for child in get_children():
	child.visible = set_visibility


func set_city_lights_visible(set_visibility: bool) -> void:
	for city_light in city_lights:
		city_light.visible = set_visibility


func _on_warehouse_warehouse_door_just_interacted() -> void:
	warehouse_interior.visible = true
	warehouse_interior.enable_collision(true)
	Globals.argo.visible = false


func _on_warehouse_interior_warehouse_interior_door_just_interacted() -> void:
	warehouse_interior.visible = false
	warehouse_interior.enable_collision(false)
	Globals.argo.visible = true


func _on_player_respawned() -> void:
	_on_warehouse_interior_warehouse_interior_door_just_interacted()


func _on_generator_generator_enabled() -> void:
	city_lights_timer.start(4.5)


func _on_city_lights_timer_timeout() -> void:
	street_lamp_lights.visible = true
	for city_light in city_lights:
		if !city_light.visible:
			city_light.visible = true
			city_lights_timer.start(randf_range(0.5, 1.0))
			return
