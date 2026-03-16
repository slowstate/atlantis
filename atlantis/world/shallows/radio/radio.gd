class_name Radio
extends Sprite2D

var current_dialogue: Dialogue


func _on_interactable_just_interacted() -> void:
	if current_dialogue != null:
		current_dialogue.queue_free()
	SfxManager.play_sfx("PressButton",0,-20,-15,0.9,1.1)
	SfxManager.play_sfx("Radio",0.5,-30,-25,0.9,1.1)
	current_dialogue = Dialogue.create("RADIO_1_MESSAGE_1", 6.0, Vector2(-5.0, -40.0))
	add_child(current_dialogue)
	await get_tree().create_timer(7.0).timeout
	current_dialogue = Dialogue.create("RADIO_1_MESSAGE_2", 6.0, Vector2(-5.0, -40.0))
	add_child(current_dialogue)
	await get_tree().create_timer(7.0).timeout
	current_dialogue = Dialogue.create("RADIO_1_MESSAGE_3", 6.0, Vector2(-5.0, -40.0))
	add_child(current_dialogue)
	await get_tree().create_timer(7.0).timeout
	current_dialogue = Dialogue.create("RADIO_1_MESSAGE_4", 6.0, Vector2(-5.0, -40.0))
	add_child(current_dialogue)
