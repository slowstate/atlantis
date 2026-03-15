extends Node

var sfx_timer: SceneTreeTimer = null


func play_music(
	music_stream_string: String,
	time_delay: float = 0.0,
	volume: float = 0.0):
	
	#Checks if file exists
	var music_track = get_node_or_null(music_stream_string)
	if music_track == null:
		print(music_stream_string+" not found")
		return

	#Creates a delay timer
	if time_delay > 0:
		sfx_timer = get_tree().create_timer(time_delay)
		await sfx_timer.timeout
		sfx_timer = null

	#Plays music
	var music_stream = music_track
	music_stream.volume_db = volume
	if music_stream.is_playing() == false:
		music_stream.play()
	
	
func fade_music(fade_duration: float = 0.0):
	for child in get_children():
		if child is AudioStreamPlayer:
			if child.is_playing():
				var sfx_fade_tween = create_tween()
				sfx_fade_tween.tween_property(child,"volume_db",-80,fade_duration)
				
				sfx_timer = get_tree().create_timer(fade_duration)
				await sfx_timer.timeout
				child.stop()
