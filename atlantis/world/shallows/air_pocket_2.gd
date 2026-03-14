extends Sprite2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	SfxManager.play_ambience_sfx("AirpocketAmbience",3,-20,-15,0.9,1.1)
	SfxManager.fade_sfx("UnderwaterAmbience",0,1)
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	SfxManager.fade_sfx("AirpocketAmbience",0,1)
	SfxManager.play_ambience_sfx("UnderwaterAmbience",5,-25,-20,0.9,1.1)
