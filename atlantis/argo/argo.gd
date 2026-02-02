class_name Argo
extends CharacterBody2D

var drive := false
var repaired := false
var argo_acceleration := 50
var argo_max_speed := 100
var argo_friction := 40


func _ready() -> void:
	Globals.argo = self


func _process(delta: float) -> void:
	if !repaired:
		return
	var move_vec = Vector2.ZERO

	if drive:
		if Input.is_action_pressed("player_move_up"):
			move_vec.y = -1
		if Input.is_action_pressed("player_move_left"):
			move_vec.x = -1
		if Input.is_action_pressed("player_move_down"):
			move_vec.y = 1
		if Input.is_action_pressed("player_move_right"):
			move_vec.x = 1

	## ARGO: Move "realistic" damping, diagonal max speed higher than single axis, more floaty
	if move_vec.x != 0:
		velocity.x = move_toward(velocity.x, move_vec.x * argo_max_speed, argo_acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, argo_friction * delta)
	if move_vec.y != 0:
		velocity.y = move_toward(velocity.y, move_vec.y * argo_max_speed, argo_acceleration * delta)
	else:
		velocity.y = move_toward(velocity.y, 0, argo_friction * delta)
	move_and_slide()


func _on_interactable_just_interacted() -> void:
	if !Globals.player.inventory.has_note(Ids.Notes.ArkPlans):
		Globals.player.inventory.add_note(Ids.Notes.ArkPlans)
	if Globals.player.currently_selected_tool == Ids.Entities.Glowstone:
		Globals.player.inventory.remove_item(Ids.Entities.Glowstone)
		repaired = true
		add_child(Dialogue.create("M's message", 3.0, Vector2(0.0, -40.0)))
