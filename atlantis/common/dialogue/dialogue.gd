class_name Dialogue
extends Label

signal dialogue_completed(dialogue_key: String)

const DIALOGUE = preload("uid://bh4c2cjfq0w6f")

var _dialogue_key: String
var _duration: float = 3.0
var _original_position: Vector2
var _final_position: Vector2
var _position_offset: float = 8.0

@onready var timer: Timer = $Timer
@onready var fade_in_timer: Timer = $FadeInTimer


static func create(
		dialogue_key: String,
		duration: float = 3.0,
		relative_position: Vector2 = Vector2(0.0, 0.0),
) -> Dialogue:
	var dialogue: Dialogue = DIALOGUE.instantiate()
	dialogue.position = relative_position - Vector2(40.0, 0.0)
	dialogue._dialogue_key = dialogue_key
	dialogue._duration = duration
	return dialogue


func _ready() -> void:
	text = tr(_dialogue_key)
	timer.start(_duration)
	#_final_position = position
	#position.y += _position_offset
	#_original_position = position
	modulate.a = 0.0
	fade_in_timer.start(1.0)


func _process(delta: float) -> void:
	print(str(position.y))
	#position.y = lerp(position.y, _final_position.y, ease(TimerUtils.timer_progress(fade_in_timer), 0.2))
	#modulate.a = lerp(modulate.a, 1.0, ease(TimerUtils.timer_progress(fade_in_timer), 0.2))
	#position.y = min(position.y + delta * 2.0 * _position_offset, _final_position.y)
	modulate.a = lerp(modulate.a, 1.0, ease(TimerUtils.timer_progress(fade_in_timer), 0.2))


func _on_timer_timeout() -> void:
	visible = false
	dialogue_completed.emit(_dialogue_key)
	queue_free()
