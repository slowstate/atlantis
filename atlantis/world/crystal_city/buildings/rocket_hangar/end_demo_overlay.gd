extends CanvasLayer

@onready var background: ColorRect = $Background
@onready var thanks_for_playing_label: Label = $ThanksForPlayingLabel
@onready var quit_button: Button = $QuitButton
@onready var end_screen_timer: Timer = $EndScreenTimer


func _ready() -> void:
	visible = false
	background.modulate.a = 0.0
	thanks_for_playing_label.modulate.a = 0.0
	quit_button.modulate.a = 0.0


func _physics_process(_delta: float) -> void:
	if !end_screen_timer.is_stopped():
		end_screen_timer.visible = true
		background.modulate.a = lerp(0.0, 1.0, TimerUtils.timer_progress(end_screen_timer))
		thanks_for_playing_label.modulate.a = lerp(0.0, 1.0, TimerUtils.timer_progress(end_screen_timer))
		quit_button.modulate.a = lerp(0.0, 1.0, TimerUtils.timer_progress(end_screen_timer))


func _on_main_menu_button_pressed() -> void:
	SfxManager.stop_all_sfx()
	get_tree().quit()
