class_name World
extends Node2D

var has_played_argo_sequence: bool = false

@onready var shallows: Node2D = $Shallows
@onready var crystal_city: CrystalCity = $CrystalCity
@onready var fish_spawn_timer: Timer = $FishSpawnTimer
@onready var player: Player = $Player
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var basic_spawn_point: Node2D = $BasicSpawnPoint
@onready var argo_bubble_particles: GPUParticles2D = $Argo/ArgoBubbleParticles


func _ready() -> void:
	player.spawn_point = ComponentUtils.get_component(basic_spawn_point, SpawnPoint.string_name) as SpawnPoint
	player.camera_2d.enabled = false
	player.visible = false
	player.user_interface.visible = false
	player.process_mode = Node.PROCESS_MODE_DISABLED


func _physics_process(_delta: float) -> void:
	if !has_played_argo_sequence and player.global_position.y >= 64:
		_play_argo_sequence()
		has_played_argo_sequence = true


func _play_argo_sequence() -> void:
	player.controls_enabled = false
	player.inventory.visible = false
	player.camera_shake(2, 12.0)
	SfxManager.play_sfx("Earthquake", 0, -10, -5, 0.9, 1.1)
	SfxManager.fade_sfx("Earthquake", 11, 2)
	await get_tree().create_timer(4.0).timeout
	animation_player.play("argo_rising")
	create_tween().tween_property(argo_bubble_particles, "amount_ratio", 0.0, 5.0)
	await get_tree().create_timer(8.0).timeout
	player.controls_enabled = true
	player.dialogue("PLAYER_DIALOGUE_2", 5.0)
	get_node("Argo").tooltip_enabled = true


func _on_fish_spawn_timer_timeout() -> void:
	var new_fish_location_x = randf_range(Globals.player.global_position.x - 160, Globals.player.global_position.x + 160)
	var new_fish_location_y = max(randf_range(Globals.player.global_position.y - 90, Globals.player.global_position.x + 90), 160)
	var new_fish = Fish.create(Vector2(new_fish_location_x, new_fish_location_y))
	add_child(new_fish)
	for i in [0, 1, 2].pick_random():
		var additional_fish = Fish.create(Vector2(new_fish.global_position.x + randf_range(-16, 16), min(new_fish.global_position.y + randf_range(-16, 16), 1050.0)), new_fish.fish_variation, new_fish.direction)
		add_child(additional_fish)

	fish_spawn_timer.start(randf_range(2.0, 8.0))


func _on_opening_scene_complete() -> void:
	player.process_mode = Node.PROCESS_MODE_INHERIT
	player.spawn_point = ComponentUtils.get_component(basic_spawn_point, SpawnPoint.string_name) as SpawnPoint
	fish_spawn_timer.start(randf_range(4.0, 8.0))
	SfxManager.play_ambience_sfx("UnderwaterAmbience", 5, -25, -20, 0.9, 1.1)
	SfxManager.play_ambience_sfx("UnderwaterDrone", 5, -20, -15, 0.9, 1.1)

	player.camera_2d.enabled = true
	player.visible = true
	player.user_interface.visible = true
	animation_player.play("player_dive")
	await get_tree().create_timer(1.6).timeout
	player.controls_enabled = true
	Globals.player.inventory.add_note(Ids.Notes.Letter, false)
