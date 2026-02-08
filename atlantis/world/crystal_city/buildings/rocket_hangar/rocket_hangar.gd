class_name RocketHangar
extends Node2D


func _on_interactable_just_interacted() -> void:
	if Globals.is_crystal_city_generator_enabled:
		# Play ending scene
		print("Play ending scene")
