class_name Fish
extends AnimatedSprite2D

enum variation {
	blue,
	brown,
	green,
	grey,
	navy,
	orange,
	orange2,
	pink,
}

const FISH = preload("uid://b0wf0flry67sd")

var fish_variation: variation
var direction: int
var move_y_frequency: float
var move_y_amplitude: float
var move_x_speed: float

@onready var alive_timer: Timer = $AliveTimer
@onready var despawn_timer: Timer = $DespawnTimer


static func create(
		initial_global_position: Vector2,
		initial_fish_variation: Fish.variation = Fish.variation.values().pick_random(),
		initial_direction: int = [-1, 1].pick_random(), # -1 = left, 1 = right
		initial_move_y_frequency: float = randf_range(0.5, 2.0),
		initial_move_y_amplitude: float = randf_range(16.0, 24.0),
		initial_move_x_speed: float = randf_range(8.0, 12.0),
) -> Fish:
	var new_fish: Fish = FISH.instantiate()
	new_fish.global_position = initial_global_position
	new_fish.fish_variation = initial_fish_variation
	new_fish.play(Fish.variation.find_key(initial_fish_variation))
	new_fish.move_y_frequency = initial_move_y_frequency
	new_fish.move_y_amplitude = initial_move_y_amplitude
	new_fish.move_x_speed = initial_move_x_speed
	new_fish.direction = initial_direction
	new_fish.move_x_speed *= new_fish.direction
	new_fish.flip_h = true if new_fish.direction == 1 else false
	return new_fish


func _ready() -> void:
	modulate.a = 0.0
	alive_timer.start(randf_range(8.0, 24.0))


func _physics_process(delta: float) -> void:
	if despawn_timer.is_stopped():
		modulate.a = min(modulate.a + delta * 0.3, 1.0)
	else:
		modulate.a = max(modulate.a - delta * 0.3, 0.0)
	move_up_and_down()
	move_left_and_right(delta)


func move_up_and_down() -> void:
	offset.y = sin(Time.get_ticks_msec() * 0.001 * move_y_frequency) * move_y_amplitude


func move_left_and_right(delta) -> void:
	global_position.x += move_x_speed * delta


func _on_alive_timer_timeout() -> void:
	despawn_timer.start(4.0)


func _on_despawn_timer_timeout() -> void:
	queue_free()
