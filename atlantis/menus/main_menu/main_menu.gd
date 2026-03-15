extends Node2D

const OPENING_SCENE = preload("uid://cfmj22pmpp3tn")

func _ready() -> void:
	get_tree().paused = false
	MusicManager.play_music("Shallows",2,-10)

func _on_start_button_pressed() -> void:
	SfxManager.play_sfx("ClickButton",0,-30,-25,0.9,1.1)
	get_tree().change_scene_to_packed(OPENING_SCENE)


func _on_quit_button_pressed() -> void:
	SfxManager.play_sfx("ClickButton",0,-30,-25,0.9,1.1)
	get_tree().quit()
