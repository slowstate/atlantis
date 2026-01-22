class_name DrowningState
extends State

var player: Player
var drowning_gradient: GradientTexture2D

@onready var oxygen_box: Area2D = $"../../OxygenBox"
@onready var drowning_timer: Timer = $DrowningTimer
@onready var drowning_overlay: Sprite2D = $"../../UserInterface/DrowningOverlay"
@onready var drowned_overlay: VBoxContainer = $"../../UserInterface/DrownedOverlay"


func enter() -> void:
	player = owner as Player
	assert(player != null, "Error: Owner must be Player scene and cannot be null.")
	drowning_timer.start(5.0)
	drowning_gradient = drowning_overlay.texture
	drowning_gradient.fill_to = Vector2(1.0, 1.0)
	drowning_overlay.visible = true


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	if oxygen_box.has_overlapping_areas() or oxygen_box.has_overlapping_bodies() or player.is_in_argo:
		transition.emit("OxygenRefillingState")
		drowning_timer.stop()
		return

	if !drowning_timer.is_stopped():
		drowning_gradient.fill_to = lerp(Vector2(1.0, 1.0), Vector2(0.499, 0.499), 1 - (drowning_timer.time_left / drowning_timer.wait_time))


func _on_drowning_timer_timeout() -> void:
	drowned_overlay.visible = true
