class_name CrystalCity
extends Node2D

var city_lights: Array[Sprite2D] = []

@onready var warehouse: Warehouse = $Warehouse
@onready var warehouse_interior: WarehouseInterior = $WarehouseInterior
@onready var city_lights_timer: Timer = $CityLightsTimer
@onready var city_lights_1: Sprite2D = $Parallax2DLayer2/CityLights1
@onready var city_lights_5: Sprite2D = $Parallax2DLayer2/CityLights5
@onready var city_lights_10: Sprite2D = $Parallax2DLayer2/CityLights10
@onready var city_lights_2: Sprite2D = $Parallax2DLayer2/CityLights2
@onready var city_lights_3: Sprite2D = $Parallax2DLayer2/CityLights3
@onready var city_lights_4: Sprite2D = $Parallax2DLayer2/CityLights4
@onready var city_lights_6: Sprite2D = $Parallax2DLayer2/CityLights6
@onready var city_lights_7: Sprite2D = $Parallax2DLayer2/CityLights7
@onready var city_lights_11: Sprite2D = $Parallax2DLayer2/CityLights11
@onready var city_lights_12: Sprite2D = $Parallax2DLayer2/CityLights12
@onready var city_lights_8: Sprite2D = $Parallax2DLayer/CityLights8
@onready var city_lights_9: Sprite2D = $Parallax2DLayer/CityLights9
@onready var city_lights_13: Sprite2D = $Parallax2DLayer/CityLights13


func _ready() -> void:
	warehouse_interior.visible = false
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
		city_lights_11,
		city_lights_12,
		city_lights_13,
	]
	set_city_lights_visible(Globals.is_crystal_city_generator_enabled)


func set_all_children_visible(set_children_visible: bool) -> void:for child in get_children():
	child.visible = set_children_visible


func set_city_lights_visible(set_city_lights_visible: bool) -> void:
	for city_light in city_lights:
		city_light.visible = set_city_lights_visible


func _on_warehouse_warehouse_door_just_interacted() -> void:
	warehouse_interior.visible = true
	warehouse_interior.enable_boundaries(true)
	Globals.argo.visible = false


func _on_warehouse_interior_warehouse_interior_door_just_interacted() -> void:
	warehouse_interior.visible = false
	warehouse_interior.enable_boundaries(false)
	Globals.argo.visible = true


func _on_player_respawned() -> void:
	_on_warehouse_interior_warehouse_interior_door_just_interacted()


func _on_generator_generator_enabled() -> void:
	city_lights_timer.start(randf_range(0.5, 1.0))


func _on_city_lights_timer_timeout() -> void:
	for city_light in city_lights:
		if !city_light.visible:
			city_light.visible = true
			city_lights_timer.start(randf_range(0.5, 1.0))
			return
