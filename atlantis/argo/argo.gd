class_name Argo
extends CharacterBody2D

var drive := false
var repaired := false
var argo_acceleration := 50
var argo_max_speed := 100
var argo_friction := 40
var tooltip_enabled: bool = false
var current_dialogue: Dialogue
var playing_m_message: bool = false
var refueling_complete_dialogue: bool = false

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_body_1: CollisionShape2D = $CollisionShapeBody1
@onready var collision_shape_body_2: CollisionShape2D = $CollisionShapeBody2
@onready var collision_shape_body_3: CollisionShape2D = $CollisionShapeBody3
@onready var collision_shape_top: CollisionShape2D = $CollisionShapeTop
@onready var collision_shape_body_4: CollisionShape2D = $CollisionShapeBody4
@onready var collision_shape_body_5: CollisionShape2D = $CollisionShapeBody5
@onready var window_light_1: PointLight2D = $Sprite2D/WindowLight1
@onready var window_light_2: PointLight2D = $Sprite2D/WindowLight2
@onready var window_light_3: PointLight2D = $Sprite2D/WindowLight3
@onready var point_light_2d: PointLight2D = $Sprite2D/PointLight2D
@onready var tooltip: Label = $Tooltip


func _ready() -> void:
	Globals.argo = self
	window_light_1.enabled = false
	window_light_2.enabled = false
	window_light_3.enabled = false
	point_light_2d.enabled = false


func _process(delta: float) -> void:
	if !repaired:
		return
	var move_vec = Vector2.ZERO

	if drive and Globals.player.controls_enabled:
		if Input.is_action_pressed("player_move_up"):
			move_vec.y = -1
		if Input.is_action_pressed("player_move_left"):
			move_vec.x = -1
			sprite_2d.scale.x = 1
		if Input.is_action_pressed("player_move_down"):
			move_vec.y = 1
		if Input.is_action_pressed("player_move_right"):
			move_vec.x = 1
			sprite_2d.scale.x = -1

	if Globals.player.inventory.visible:
		move_vec = Vector2.ZERO
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

	if move_vec != Vector2.ZERO:
		SfxManager.play_continuous_sfx("ARGODrive", 0, -20, -15, 0.9, 1.1)
		SfxManager.play_continuous_sfx("ARGODisturbWater", 0, -25, -20, 0.9, 1.1)
	else:
		SfxManager.stop_sfx("ARGODrive")
		SfxManager.fade_sfx("ARGODisturbWater", 0, 5)


func _input(event: InputEvent) -> void:
	if !drive or repaired or Globals.player.inventory.visible:
		return
	if event.is_action_pressed("player_move_up") or \
	event.is_action_pressed("player_move_left") or \
	event.is_action_pressed("player_move_down") or \
	event.is_action_pressed("player_move_right"):
		dialogue("FUEL RESERVES EMPTY", 3.0, Vector2(0.0, -40.0))


func dialogue(dialogue_key: String, duration: float = 3.0, relative_position: Vector2 = Vector2(0.0, -36.0)) -> void:
	if current_dialogue:
		current_dialogue.queue_free()
	current_dialogue = Dialogue.create(dialogue_key, duration, relative_position)
	add_child(current_dialogue)


func _on_interactable_just_interacted() -> void:
	tooltip_enabled = false
	var tween = create_tween()
	tween.tween_property(tooltip, "modulate:a", 0, 0.5)
	if Globals.player.currently_selected_tool == Ids.Items.Glowstone and !repaired:
		playing_m_message = true
		Globals.player.inventory.remove_item(Ids.Items.Glowstone)
		SfxManager.play_sfx("DepositGlowstone", 0, -20, -15, 0.9, 1.1)
		repaired = true
		window_light_1.enabled = true
		window_light_2.enabled = true
		window_light_3.enabled = true
		Globals.player.dialogue("There's an unplayed message", 3.0)
		await get_tree().create_timer(2.0).timeout
		SfxManager.play_sfx("EmailReceived", 0, -20, -15, 0.9, 1.1)
		dialogue("ARGO_M_MESSAGE_1", 4.0, Vector2(0.0, -40.0))
		await get_tree().create_timer(4.5).timeout
		dialogue("ARGO_M_MESSAGE_2", 4.0, Vector2(0.0, -40.0))
		await get_tree().create_timer(4.5).timeout
		dialogue("ARGO_M_MESSAGE_3", 4.0, Vector2(0.0, -40.0))
		await get_tree().create_timer(4.5).timeout
		dialogue("ARGO_M_MESSAGE_4", 4.0, Vector2(0.0, -40.0))
		await get_tree().create_timer(4.5).timeout
		dialogue("ARGO_M_MESSAGE_5", 6.0, Vector2(0.0, -40.0))
		await get_tree().create_timer(6.5).timeout
		dialogue("ARGO_M_MESSAGE_6", 5.0, Vector2(0.0, -40.0))
		await get_tree().create_timer(5.5).timeout
		playing_m_message = false
		return
	if !Globals.player.inventory.has_note(Ids.Notes.ArkPlans):
		Globals.player.inventory.add_note(Ids.Notes.ArkPlans)
		SfxManager.play_sfx("EmailReceived", 0, -20, -15, 0.9, 1.1)
	if repaired:
		point_light_2d.enabled = true
		if !refueling_complete_dialogue:
			refueling_complete_dialogue = true
			dialogue("REFUELING COMPLETE", 5.0, Vector2(0.0, -40.0))


func _on_interaction_box_area_entered(_area: Area2D) -> void:
	if tooltip_enabled == true:
		var tween = create_tween()
		tween.tween_property(tooltip, "modulate:a", 1, 0.5)


func _on_interaction_box_area_exited(_area: Area2D) -> void:
	if tooltip_enabled == true:
		var tween = create_tween()
		tween.tween_property(tooltip, "modulate:a", 0, 0.5)
