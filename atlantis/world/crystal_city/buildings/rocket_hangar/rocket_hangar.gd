class_name RocketHangar
extends Node2D

const MAIN_MENU = preload("uid://cbtihbid7ppjv")

@onready var end_screen_timer: Timer = $EndScreen/EndScreenTimer


func _on_interactable_just_interacted() -> void:
	if Globals.is_crystal_city_generator_enabled:
		Globals.player.controls_enabled = false
		end_screen_timer.start(3.0)
