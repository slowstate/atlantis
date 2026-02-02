class_name Generator
extends Node2D

var has_glowstone := false
var has_diode := false


func _on_interactable_just_interacted() -> void:
	if Globals.player.inventory.items.has(Ids.Entities.Glowstone):
		Globals.player.inventory.remove_item(Ids.Entities.Glowstone)
