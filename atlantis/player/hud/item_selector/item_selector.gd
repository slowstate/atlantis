class_name ItemSelector
extends PanelContainer

var currently_selected_item_index := 0

@onready var currently_selected_item_texture: TextureRect = $CurrentlySelectedItemTexture


func _process(delta: float) -> void:
	currently_selected_item_texture.modulate.a = max(currently_selected_item_texture.modulate.a - delta / 2, 0.0)


func _input(event: InputEvent) -> void:
	var player_items := Globals.player.inventory.items.keys() as Array[Ids.Items]
	if player_items.is_empty() or !player_items:
		return

	if event.is_action_pressed("player_select_next_item"):
		if Globals.player.first_glowstone_picked_up:
			create_tween().tween_property(Globals.player.switch_tool_label, "modulate:a", 0, 0.5)
		if currently_selected_item_index >= player_items.size() - 1:
			currently_selected_item_index = 0
		else:
			currently_selected_item_index += 1
		currently_selected_item_texture.modulate.a = 1.0
	if event.is_action_pressed("player_select_previous_item"):
		if Globals.player.first_glowstone_picked_up:
			create_tween().tween_property(Globals.player.switch_tool_label, "modulate:a", 0, 0.5)
		if currently_selected_item_index <= 0:
			currently_selected_item_index = player_items.size() - 1
		else:
			currently_selected_item_index -= 1
		currently_selected_item_texture.modulate.a = 1.0

	while currently_selected_item_index >= player_items.size():
		currently_selected_item_index -= 1
	if !currently_selected_item_texture.texture:
		currently_selected_item_texture.modulate.a = 1.0
	currently_selected_item_texture.texture = Icons.icon_by_item_id[player_items[currently_selected_item_index]]
