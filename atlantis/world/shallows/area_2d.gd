extends Area2D


func _on_area_entered(_area: Area2D) -> void:
	SfxManager.play_ambience_sfx("LandAmbience", 3, -30, -25, 0.9, 1.1)
	SfxManager.fade_sfx("UnderwaterAmbience", 0, 1)


func _on_area_exited(_area: Area2D) -> void:
	SfxManager.fade_sfx("LandAmbience", 0, 1)
	SfxManager.play_ambience_sfx("UnderwaterAmbience", 5, -25, -20, 0.9, 1.1)
