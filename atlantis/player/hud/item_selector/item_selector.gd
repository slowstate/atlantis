class_name ItemSelector
extends Control

var currently_selected_item_index := 0

@onready var currently_selected_item_texture: TextureRect = $CurrentlySelectedItemTexture


func _input(event: InputEvent) -> void:
	var player_items := Globals.player.inventory.items.keys() as Array[Ids.Entities]
	if player_items.is_empty() or !player_items:
		return

	if event.is_action_pressed("player_select_next_item"):
		if currently_selected_item_index >= player_items.size() - 1:
			currently_selected_item_index = 0
		else:
			currently_selected_item_index += 1
	if event.is_action_pressed("player_select_previous_item"):
		if currently_selected_item_index <= 0:
			currently_selected_item_index = player_items.size() - 1
		else:
			currently_selected_item_index -= 1

	while currently_selected_item_index >= player_items.size():
		currently_selected_item_index -= 1
	currently_selected_item_texture.texture = Icons.icon_by_entity_id[player_items[currently_selected_item_index]]
