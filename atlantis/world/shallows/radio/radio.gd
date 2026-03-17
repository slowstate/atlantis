class_name Radio
extends Sprite2D

var current_dialogue: Dialogue
var playing_dialogue: bool = false


func dialogue(dialogue_key: String, duration: float = 3.0, relative_position: Vector2 = Vector2(0.0, -36.0)) -> void:
	if current_dialogue:
		current_dialogue.queue_free()
	current_dialogue = Dialogue.create(dialogue_key, duration, relative_position)
	add_child(current_dialogue)


func _on_interactable_just_interacted() -> void:
	if playing_dialogue:
		return
	playing_dialogue = true
	SfxManager.play_sfx("PressButton", 0, -20, -15, 0.9, 1.1)
	SfxManager.play_sfx("Radio", 0.5, -30, -25, 0.9, 1.1)
	dialogue("RADIO_1_MESSAGE_1", 6.0, Vector2(-5.0, -40.0))
	await get_tree().create_timer(7.0).timeout
	SfxManager.play_sfx("Radio", 0.5, -40, -35, 0.7, 0.9)
	dialogue("RADIO_1_MESSAGE_2", 6.0, Vector2(-5.0, -40.0))
	await get_tree().create_timer(7.0).timeout
	SfxManager.play_sfx("Radio", 0.5, -40, -35, 0.9, 1.1)
	dialogue("RADIO_1_MESSAGE_3", 6.0, Vector2(-5.0, -40.0))
	await get_tree().create_timer(7.0).timeout
	SfxManager.play_sfx("Radio", 0.5, -40, -35, 0.7, 0.9)
	dialogue("RADIO_1_MESSAGE_4", 6.0, Vector2(-5.0, -40.0))
	await get_tree().create_timer(6.0).timeout
	SfxManager.play_sfx("PressButton", 0, -20, -15, 1.3, 1.5)
	playing_dialogue = false
