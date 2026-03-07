class_name World
extends Node2D

@onready var shallows: Node2D = $Shallows
@onready var crystal_city: CrystalCity = $CrystalCity
@onready var fish_spawn_timer: Timer = $FishSpawnTimer
@onready var player: Player = $Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fade_in_overlay: Sprite2D = $FadeInOverlay
@onready var fade_in_timer: Timer = $FadeInTimer


func _ready() -> void:
	fish_spawn_timer.start(randf_range(4.0, 8.0))
	player.controls_enabled = false
	fade_in_overlay.modulate.a = 1.0
	fade_in_timer.start(2.0)


func _physics_process(_delta: float) -> void:
	if !fade_in_timer.is_stopped():
		fade_in_overlay.modulate.a = 1.0 - TimerUtils.timer_progress(fade_in_timer)


func _on_fish_spawn_timer_timeout() -> void:
	var new_fish_location_x = randf_range(Globals.player.global_position.x - 160, Globals.player.global_position.x + 160)
	var new_fish_location_y = max(randf_range(Globals.player.global_position.y - 90, Globals.player.global_position.x + 90), 160)
	var new_fish = Fish.create(Vector2(new_fish_location_x, new_fish_location_y))
	add_child(new_fish)
	for i in [0, 1, 2].pick_random():
		var additional_fish = Fish.create(Vector2(new_fish.global_position.x + randf_range(-16, 16), min(new_fish.global_position.y + randf_range(-16, 16), 1050.0)), new_fish.fish_variation, new_fish.direction)
		add_child(additional_fish)

	fish_spawn_timer.start(randf_range(4.0, 16.0))


func _on_fade_in_timer_timeout() -> void:
	animation_player.play("player_dive")
	await get_tree().create_timer(2.0).timeout
	player.controls_enabled = true
