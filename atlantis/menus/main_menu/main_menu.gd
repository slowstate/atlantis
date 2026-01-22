extends Node2D

const SHALLOWS = preload("uid://bareqc1eyxlpq")

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(SHALLOWS)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
