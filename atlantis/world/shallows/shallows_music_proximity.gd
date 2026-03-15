extends Area2D


func _on_area_entered(area: Area2D) -> void:
	MusicManager.fade_music(2)
	MusicManager.play_music("Shallows",0,-10)
