class_name WarehouseGenerator
extends Node2D

var interacted := false

@onready var photonic_invertor: PhotonicInvertor = $PhotonicInvertor


func _ready() -> void:
	photonic_invertor.visible = false


func _on_interactable_just_interacted() -> void:
	if Globals.player.currently_selected_tool == Ids.Items.MiningTool:
		if !interacted:
			interacted = true
			photonic_invertor.visible = true
			# photonic_invertor.play_animation()
