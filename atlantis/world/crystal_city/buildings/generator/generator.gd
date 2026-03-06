class_name Generator
extends Node2D

signal generator_enabled

var has_glowstone: bool = false
var has_photonic_invertor: = false
var has_played_first_interaction: bool = false
var battery_partial_flicker_count: int = 0

@onready var photonic_invertor: Sprite2D = $PhotonicInvertor
@onready var photonic_invertor_broken: Sprite2D = $PhotonicInvertorBroken
@onready var photonic_invertor_sparks: GPUParticles2D = $PhotonicInvertorSparks
@onready var photonic_invertor_break_timer: Timer = $PhotonicInvertorBreakTimer
@onready var photonic_invertor_new: Sprite2D = $PhotonicInvertorNew
@onready var glowstone_before: Sprite2D = $GlowstoneBefore
@onready var glowstone_after: Sprite2D = $GlowstoneAfter
@onready var battery_indicator_partial: Sprite2D = $BatteryIndicatorPartial
@onready var battery_partial_flicker_timer: Timer = $BatteryPartialFlickerTimer
@onready var glowstone_flicker_timer: Timer = $GlowstoneFlickerTimer
@onready var glowstone_break_timer: Timer = $GlowstoneBreakTimer
@onready var glowstone_new: Sprite2D = $GlowstoneNew


func _physics_process(delta: float) -> void:
	if !photonic_invertor_break_timer.is_stopped() and photonic_invertor_broken.visible:
		photonic_invertor_broken.modulate.a = 1.0 - TimerUtils.timer_progress(photonic_invertor_break_timer)
	if !glowstone_break_timer.is_stopped() and glowstone_after.visible:
		glowstone_after.modulate.a = 1.0 - TimerUtils.timer_progress(glowstone_break_timer)


func _on_interactable_just_interacted() -> void:
	if !has_played_first_interaction:
		_play_photonic_invertor_break_sequence()
		has_played_first_interaction = true
		return
	if !has_photonic_invertor:
		photonic_invertor_sparks.emitting = true

	if has_glowstone and has_photonic_invertor:
		generator_enabled.emit()
		Globals.is_crystal_city_generator_enabled = true


func _play_photonic_invertor_break_sequence() -> void:
	photonic_invertor_sparks.emitting = true
	photonic_invertor_break_timer.start(0.5)


func _on_photonic_invertor_break_timer_timeout() -> void:
	if photonic_invertor.visible:
		photonic_invertor.visible = false
		photonic_invertor_broken.visible = true
		photonic_invertor_break_timer.start(5.0)


func _play_glowstone_break_sequence() -> void:
	battery_partial_flicker_timer.start(0.2)


func _on_battery_partial_flicker_timer_timeout() -> void:
	if battery_indicator_partial.visible:
		battery_indicator_partial.visible = false
		battery_partial_flicker_timer.start(0.2)
	else:
		if battery_partial_flicker_count > 3:
			glowstone_before.visible = false
			glowstone_flicker_timer.start(0.2)
			return
		battery_partial_flicker_count += 1
		battery_indicator_partial.visible = !battery_indicator_partial.visible
		battery_partial_flicker_timer.start(0.2)


func _on_glowstone_flicker_timer_timeout() -> void:
	if !glowstone_before.visible:
		glowstone_before.visible = true
		glowstone_flicker_timer.start(0.2)
	else:
		glowstone_before.visible = false
		glowstone_break_timer.start(5.0)


func _on_photonic_invertor_socket_photonic_invertor_just_interacted() -> void:
	if !has_photonic_invertor and Globals.player.currently_selected_tool == Ids.Items.PhotonicInvertor:
		Globals.player.inventory.remove_item(Ids.Items.PhotonicInvertor)
		has_photonic_invertor = true
		photonic_invertor_new.visible = true
		_play_glowstone_break_sequence()


func _on_glowstone_socket_glowstone_just_interacted() -> void:
	if !has_glowstone and Globals.player.currently_selected_tool == Ids.Items.Glowstone:
		Globals.player.inventory.remove_item(Ids.Items.Glowstone)
		has_glowstone = true
		glowstone_new.visible = true
