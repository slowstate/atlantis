class_name OxygenDepletingState
extends State

var player: Player
var oxygen_deplete_rate := 1.0
var drowning_gradient: GradientTexture2D

@onready var oxygen_box: Area2D = $"../../OxygenBox"
@onready var oxygen_meter_label: Label = $"../../UserInterface/OxygenMeterLabel"
@onready var drowning_overlay: Sprite2D = $"../../UserInterface/DrowningOverlay"


func enter() -> void:
	player = owner as Player
	assert(player != null, "Error: Owner must be Player scene and cannot be null.")
	drowning_gradient = drowning_overlay.texture


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	if oxygen_box.has_overlapping_areas() or oxygen_box.has_overlapping_bodies() or player.is_in_argo:
		transition.emit("OxygenRefillingState")
		return

	if player.god_mode:
		return

	player.oxygen = clamp(player.oxygen - oxygen_deplete_rate * delta, 0.0, player.OXYGEN_MAX)
	oxygen_meter_label.text = "O₂: " + str(roundi(player.oxygen))
	drowning_gradient.fill_to = clamp(drowning_gradient.fill_to + Vector2(1.0, 1.0) * delta, Vector2(0.499, 0.499), Vector2(1.0, 1.0))

	if player.oxygen <= 0:
		transition.emit("DrowningState")
