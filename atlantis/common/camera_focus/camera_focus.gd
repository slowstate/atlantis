class_name CameraFocus
extends Node

@export var focus_point: Node2D

var focus_enabled: bool = false
var focus_weight: float = 0.5 # How much closer the camera focuses on the focus point
var zoom: float = 0.7

@onready var focus_in_timer: Timer = $FocusInTimer
@onready var focus_out_timer: Timer = $FocusOutTimer


func _physics_process(_delta: float) -> void:
	if !focus_enabled:
		return

	if !focus_in_timer.is_stopped():
		Globals.player.camera_2d.global_position.x = lerpf(Globals.player.global_position.x, focus_point.global_position.x, ease(TimerUtils.timer_progress(focus_in_timer), 0.5) * focus_weight)
		Globals.player.camera_2d.global_position.y = lerpf(Globals.player.global_position.y, focus_point.global_position.y, ease(TimerUtils.timer_progress(focus_in_timer), 0.5) * focus_weight)
		Globals.player.camera_2d.zoom.x = lerpf(1.0, zoom, ease(TimerUtils.timer_progress(focus_in_timer), 0.5))
		Globals.player.camera_2d.zoom.y = lerpf(1.0, zoom, ease(TimerUtils.timer_progress(focus_in_timer), 0.5))
	elif !focus_out_timer.is_stopped():
		Globals.player.camera_2d.global_position.x = lerpf(Globals.player.camera_2d.global_position.x, Globals.player.global_position.x, ease(TimerUtils.timer_progress(focus_out_timer), 0.5))
		Globals.player.camera_2d.global_position.y = lerpf(Globals.player.camera_2d.global_position.y, Globals.player.global_position.y, ease(TimerUtils.timer_progress(focus_out_timer), 0.5))
		Globals.player.camera_2d.zoom.x = lerpf(Globals.player.camera_2d.zoom.x, 1.0, ease(TimerUtils.timer_progress(focus_out_timer), 0.5))
		Globals.player.camera_2d.zoom.y = lerpf(Globals.player.camera_2d.zoom.y, 1.0, ease(TimerUtils.timer_progress(focus_out_timer), 0.5))
	else:
		Globals.player.camera_2d.global_position.x = lerpf(Globals.player.global_position.x, focus_point.global_position.x, focus_weight)
		Globals.player.camera_2d.global_position.y = lerpf(Globals.player.global_position.y, focus_point.global_position.y, focus_weight)


func _on_body_entered(_body: Node2D) -> void:
	focus_enabled = true
	focus_out_timer.stop()
	focus_in_timer.start(2.0)


func _on_body_exited(_body: Node2D) -> void:
	focus_in_timer.stop()
	focus_out_timer.start(3.0)


func _on_focus_out_timer_timeout() -> void:
	focus_enabled = false
