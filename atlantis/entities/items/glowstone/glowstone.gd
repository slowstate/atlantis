class_name Glowstone
extends Item

var mined := false

@onready var collectable: Collectable = $Collectable


func _init() -> void:
	id = Ids.Items.Glowstone


func _physics_process(_delta: float) -> void:
	if mined:
		collectable.collect()
		queue_free()


func _on_interactable_just_interacted() -> void:
	if Globals.player.inventory.has_item(Ids.Items.MiningTool):
		mined = true
	else:
		SfxManager.play_sfx("IncorrectTool",0,-20,-15,0.9,1.1)
