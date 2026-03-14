class_name WarehouseGenerator
extends Node2D

var interacted := false

@onready var photonic_invertor: PhotonicInvertor = $PhotonicInvertor
@onready var panel: Sprite2D = $Panel
@onready var interaction_box: Area2D = $InteractionBox


func _on_interactable_just_interacted() -> void:
	if Globals.player.currently_selected_tool == Ids.Items.MiningTool:
		if !interacted:
			interacted = true
			panel.visible = false
			interaction_box.monitoring = false
			interaction_box.monitorable = false
			# photonic_invertor.play_animation()
