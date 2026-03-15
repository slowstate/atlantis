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
			interaction_box.monitoring = false
			interaction_box.monitorable = false
			# photonic_invertor.play_animation()
			Globals.player.controls_enabled = false
			SfxManager.play_sfx("DismantleMachine",0,-15,-10,0.9,1.1)
			var sfx_timer = get_tree().create_timer(2.0)
			await sfx_timer.timeout
			Globals.player.controls_enabled = true
			panel.visible = false
			photonic_invertor.visible = true
