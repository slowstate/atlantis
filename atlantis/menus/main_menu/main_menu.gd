extends Node2D

const WORLD = preload("uid://chhtc74hdy2e5")


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(WORLD)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
