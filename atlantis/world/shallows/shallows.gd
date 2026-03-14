extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.play("bridge_sway")


func _on_open_air_area_entered(_area: Area2D) -> void:
	SfxManager.play_ambience_sfx("LandAmbience", 3, -20, -15, 0.9, 1.1)
	SfxManager.fade_sfx("UnderwaterAmbience", 0, 1)


func _on_open_air_area_exited(_area: Area2D) -> void:
	SfxManager.fade_sfx("LandAmbience", 0, 1)
	SfxManager.play_ambience_sfx("UnderwaterAmbience", 5, -25, -20, 0.9, 1.1)
