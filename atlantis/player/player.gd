class_name Player
extends CharacterBody2D

const OXYGEN_MAX := 30.0

var oxygen := OXYGEN_MAX
var spawn_point: SpawnPoint
var acceleration := 200
var max_speed := 50
var friction := 100
var is_in_argo := false
var glowstone := 0

@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var oxygen_meter_label: Label = $UserInterface/OxygenMeterLabel
@onready var oxygen_box: Area2D = $OxygenBox
@onready var interaction_box: Area2D = $InteractionBox
@onready var inventory: Inventory = $UserInterface/Inventory
@onready var drowning_overlay: Sprite2D = $UserInterface/DrowningOverlay
@onready var drowned_overlay: VBoxContainer = $UserInterface/DrownedOverlay


func _ready() -> void:
	Globals.player = self
	player_sprite.visible = !is_in_argo
	inventory.visible = false


func _process(delta: float) -> void:
	if is_in_argo:
		global_position = Globals.argo.global_position
		velocity = Vector2(0, 0)
		return

	var move_vec = Vector2.ZERO
	if Input.is_action_pressed("player_move_up"):
		move_vec.y = -1
	if Input.is_action_pressed("player_move_left"):
		move_vec.x = -1
	if Input.is_action_pressed("player_move_down"):
		move_vec.y = 1
	if Input.is_action_pressed("player_move_right"):
		move_vec.x = 1

	## Swimming: Fixed max speed, better "handling", floating damping suddenly drops when moving
	if move_vec != Vector2.ZERO:
		velocity = velocity.move_toward(move_vec.normalized() * max_speed, acceleration * delta)
	else:
		# Apply damping (friction) when no input is pressed
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("player_inventory"):
		inventory.visible = !inventory.visible

	if event.is_action_pressed("player_interact"):
		var overlapping_interactable_areas: Array[Area2D] = interaction_box.get_overlapping_areas()
		if overlapping_interactable_areas.is_empty():
			return
		var frontmost_interactable = overlapping_interactable_areas.front().owner

		if frontmost_interactable is Argo:
			enter_argo(!is_in_argo)

		if frontmost_interactable is Entity:
			if frontmost_interactable.has_component(Interactable.string_name):
				var interactable_component = (frontmost_interactable.get_component(Interactable.string_name) as Interactable)
				interactable_component.interact()


func enter_argo(is_entering: bool) -> void:
	is_in_argo = is_entering
	player_sprite.visible = !is_in_argo
	Globals.argo.drive = is_in_argo
	if is_in_argo:
		spawn_point = Globals.argo.get_component(SpawnPoint.string_name)


func _on_respawn_button_pressed() -> void:
	if spawn_point == null:
		spawn_point = Globals.argo.get_component(SpawnPoint.string_name) as SpawnPoint
	global_position = spawn_point.get_global_position()

	drowning_overlay.visible = false
	drowned_overlay.visible = false

	player_state_machine.set_state("OxygenDepletingState")
	oxygen = OXYGEN_MAX
	enter_argo(true)
