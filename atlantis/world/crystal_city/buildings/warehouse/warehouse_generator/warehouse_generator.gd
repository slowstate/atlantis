class_name WarehouseGenerator
extends Node2D

var interacted := false

@onready var diode: Diode = $Diode


func _ready() -> void:
	diode.visible = false


func _on_interactable_just_interacted() -> void:
	if Globals.player.currently_selected_tool == Ids.Items.MiningTool:
		if !interacted:
			interacted = true
			diode.visible = true
			# Diode.play_animation()
