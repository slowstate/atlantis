extends Area2D


func _on_area_entered(area: Area2D) -> void:
	#MusicManager.fade_music(2)
	if Globals.is_crystal_city_generator_enabled == false:
		MusicManager.play_music("UnlitCrystalCity",0,-5,2)
	else:
		MusicManager.play_music("LitCrystalCity",0,-5,2)
