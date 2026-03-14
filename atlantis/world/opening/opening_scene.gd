extends Node2D

const WORLD = preload("uid://chhtc74hdy2e5")

@onready var fade_in_overlay: Sprite2D = $FadeInOverlay
@onready var fade_in_timer: Timer = $FadeInTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var water_splash_particles: GPUParticles2D = $WaterSplashParticles


func _ready() -> void:
	animated_sprite_2d.play("default")
	fade_in_overlay.visible = true
	fade_in_overlay.modulate.a = 1.0
	fade_in_timer.start(3.0)
	SfxManager.play_sfx("LandAmbience",0,-20,-15,0.9,1.1)

func _process(_delta: float) -> void:
	if !fade_in_timer.is_stopped():
		fade_in_overlay.modulate.a = 1.0 - TimerUtils.timer_progress(fade_in_timer)


func _on_fade_in_timer_timeout() -> void:
	await get_tree().create_timer(2.0).timeout
	animated_sprite_2d.play("jump_off")
	animation_player.play("jump_off")
	await get_tree().create_timer(0.45).timeout
	water_splash_particles.emitting = true
	await get_tree().create_timer(0.1).timeout
	SfxManager.stop_sfx("LandAmbience")
	SfxManager.play_sfx("PlayerDive",0,-15,-10,0.9,1.1)
	get_tree().change_scene_to_packed(WORLD)
