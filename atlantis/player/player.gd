class_name Player
extends CharacterBody2D

const OXYGEN_MAX := 30.0

var god_mode := false
var oxygen := OXYGEN_MAX
var spawn_point: SpawnPoint
var acceleration := 200
var max_speed := 50
var friction := 100
var is_in_argo := false
var glowstone := 0
var currently_selected_tool: Ids.Items:
	get():
		if inventory.items.size() <= 0:
			return Ids.Items.Nothing
		return inventory.items.keys().get(item_selector.currently_selected_item_index) as Ids.Items
var current_dialogue: Dialogue

@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var oxygen_meter_label: Label = $UserInterface/OxygenMeterLabel
@onready var oxygen_box: Area2D = $OxygenBox
@onready var interaction_box: Area2D = $InteractionBox
@onready var inventory: Inventory = $UserInterface/Inventory
@onready var notification: Sprite2D = $UserInterface/Notification
@onready var drowning_overlay: Sprite2D = $UserInterface/DrowningOverlay
@onready var drowned_overlay: VBoxContainer = $UserInterface/DrownedOverlay
@onready var item_selector: ItemSelector = $UserInterface/ItemSelector


func _ready() -> void:
	Globals.player = self
	player_sprite.visible = !is_in_argo
	inventory.visible = false


func _process(delta: float) -> void:
	if is_in_argo:
		global_position = Globals.argo.global_position
		velocity = Vector2(0, 0)
		return

	if Input.is_action_just_pressed("god_mode") and OS.is_debug_build():
		god_mode = !god_mode
		if god_mode:
			acceleration = 400
			max_speed = 200
			friction = 200
		else:
			acceleration = 200
			max_speed = 50
			friction = 100
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
		notification.visible = false

	if event.is_action_pressed("player_interact"):
		var overlapping_interactable_areas: Array[Area2D] = interaction_box.get_overlapping_areas().filter(func(area): return area.owner.visible)
		overlapping_interactable_areas.sort_custom(func(a: Area2D, b: Area2D): return a.owner.z_index > b.owner.z_index)
		if overlapping_interactable_areas.is_empty():
			return
		var frontmost_interactable = overlapping_interactable_areas.front().owner

		if frontmost_interactable is Argo:
			var argo = frontmost_interactable
			if !argo.repaired and !is_in_argo:
				var interactable_component = ComponentUtils.get_component(argo, Interactable.string_name) as Interactable
				interactable_component.interact()
				if argo.repaired:
					return
			enter_argo(!is_in_argo)

		if frontmost_interactable is Item or frontmost_interactable is Note:
			var interactable_component = ComponentUtils.get_component(frontmost_interactable, Interactable.string_name) as Interactable
			interactable_component.interact()

		if frontmost_interactable is Generator:
			var generator = frontmost_interactable
			var interactable_component = ComponentUtils.get_component(generator, Interactable.string_name) as Interactable
			interactable_component.interact()
			if !generator.has_glowstone or !generator.has_diode:
				_dialogue("I think the generator is still missing something")

		if frontmost_interactable is Warehouse:
			var warehouse = frontmost_interactable
			if !warehouse.is_lit:
				_dialogue("It's too dark in here, maybe I can light it up somehow")
			var interactable_component = ComponentUtils.get_component(warehouse, Interactable.string_name) as Interactable
			interactable_component.interact()

		if frontmost_interactable is WarehouseInterior:
			var warehouse = frontmost_interactable
			var interactable_component = ComponentUtils.get_component(warehouse, Interactable.string_name) as Interactable
			interactable_component.interact()

		if frontmost_interactable is WarehouseGenerator:
			var warehouse_generator = frontmost_interactable
			var interactable_component = ComponentUtils.get_component(warehouse_generator, Interactable.string_name) as Interactable
			interactable_component.interact()

		if frontmost_interactable is WrongDiode:
			_dialogue("This diode won't fit the generator")


func enter_argo(is_entering: bool) -> void:
	is_in_argo = is_entering
	player_sprite.visible = !is_in_argo
	Globals.argo.drive = is_in_argo
	if is_in_argo:
		spawn_point = ComponentUtils.get_component(Globals.argo, SpawnPoint.string_name) as SpawnPoint


func _on_respawn_button_pressed() -> void:
	if spawn_point == null:
		spawn_point = ComponentUtils.get_component(Globals.argo, SpawnPoint.string_name) as SpawnPoint
	global_position = spawn_point.get_global_position()

	drowning_overlay.visible = false
	drowned_overlay.visible = false

	player_state_machine.set_state("OxygenDepletingState")
	oxygen = OXYGEN_MAX
	enter_argo(true)

	SignalBus.player_respawned.emit()


func _dialogue(dialogue_key: String, duration: float = 3.0, relative_position: Vector2 = Vector2(0.0, -32.0)) -> void:
	if current_dialogue:
		current_dialogue.queue_free()
	current_dialogue = Dialogue.create(dialogue_key, duration, relative_position)
	add_child(current_dialogue)
