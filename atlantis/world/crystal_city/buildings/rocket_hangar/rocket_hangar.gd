class_name RocketHangar
extends Node2D

@onready var end_screen_timer: Timer = $EndScreen/EndScreenTimer
@onready var rocket_hangar_lights_on: Sprite2D = $RocketHangarLightsOn
@onready var hangar_interior: Sprite2D = $HangarInterior


func _process(_delta: float) -> void:
	if Globals.is_crystal_city_generator_enabled:
		rocket_hangar_lights_on.visible = true
		hangar_interior.visible = false


func _on_interactable_just_interacted() -> void:
	if Globals.is_crystal_city_generator_enabled:
		Globals.player.controls_enabled = false
		end_screen_timer.start(3.0)
