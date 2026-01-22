class_name Collectable
extends Node

static var string_name = &"Collectable"


func _enter_tree() -> void:
	owner.set_meta(string_name, self)
	assert(Icons.IconByEntityId[(owner as Entity).id] != null, "Error: Missing entity icon")


func _exit_tree() -> void:
	if owner != null:
		owner.remove_meta(string_name)


func collect() -> void:
	(Globals.player.inventory as Inventory).add_item(owner)
