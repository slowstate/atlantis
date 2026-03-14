extends Area2D


func _on_body_entered(body: Node2D) -> void:
	Globals.player.dialogue("I should investigate the city")
