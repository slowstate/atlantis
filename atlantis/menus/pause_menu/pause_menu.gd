extends CanvasLayer

var MAIN_MENU = load("uid://cbtihbid7ppjv")


func _init() -> void:
	visible = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_pause"):
		if get_tree().paused:
			get_tree().paused = false
			visible = false
		else:
			get_tree().paused = true
			visible = true


func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_MENU)
