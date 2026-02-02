class_name Collectable
extends Node

static var string_name = &"Collectable"


func _enter_tree() -> void:
	owner.set_meta(string_name, self)
	if owner is Entity:
		assert(Icons.icon_by_entity_id[(owner as Entity).id] != null, "Error: Missing entity icon for " + str(owner))
	if owner is Note:
		assert(Icons.icon_by_note_id[(owner as Note).id] != null, "Error: Missing note icon for " + str(owner))


func _exit_tree() -> void:
	if owner != null:
		owner.remove_meta(string_name)


func collect() -> void:
	if owner is Entity:
		(Globals.player.inventory as Inventory).add_item(owner.id)
	if owner is Note:
		(Globals.player.inventory as Inventory).add_note(owner.id)
