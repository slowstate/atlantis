class_name Dialogue
extends Label

signal dialogue_completed(dialogue_key: String)

const DIALOGUE = preload("uid://bh4c2cjfq0w6f")

var _dialogue_key: String
var _duration: float = 3.0

@onready var timer: Timer = $Timer


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
	timer.start(_duration)
	text = tr(_dialogue_key)


func _on_timer_timeout() -> void:
	visible = false
	dialogue_completed.emit(_dialogue_key)
	queue_free()
