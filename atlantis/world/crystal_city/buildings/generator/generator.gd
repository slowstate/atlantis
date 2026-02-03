class_name Generator
extends Node2D

signal generator_enabled

var has_glowstone := false
var has_diode := false


func _on_interactable_just_interacted() -> void:
	if !has_glowstone and Globals.player.currently_selected_tool == Ids.Items.Glowstone:
		Globals.player.inventory.remove_item(Ids.Items.Glowstone)
		has_glowstone = true
	elif !has_diode and Globals.player.currently_selected_tool == Ids.Items.Diode:
		Globals.player.inventory.remove_item(Ids.Items.Diode)
		has_diode = true

	if has_glowstone and has_diode:
		generator_enabled.emit()
