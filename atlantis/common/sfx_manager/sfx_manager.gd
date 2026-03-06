extends Node

var sfx_timer: SceneTreeTimer = null

func play_sfx(
	sfx_stream_string: String,
	time_delay: float = 0.0,
	volume_db_min: float = 0.0,
	volume_db_max: float = 0.0,
	pitch_scale_min: float = 1.0,
	pitch_scale_max: float = 1.0):
	stop_sfx(sfx_stream_string)
	
	#Creates a delay timer
	if time_delay > 0:
		sfx_timer = get_tree().create_timer(time_delay)
		await sfx_timer.timeout
		
	#Plays sound
	var sfx_type = get_node_or_null(sfx_stream_string)
	if sfx_type == null:
		print(sfx_stream_string+" not found")
		return
	var sfx_index = randi_range(0,sfx_type.get_child_count()-1)
	var sfx_stream = sfx_type.get_child(sfx_index)
	sfx_stream.volume_db = randf_range(volume_db_min, volume_db_max)
	sfx_stream.pitch_scale = randf_range(pitch_scale_min, pitch_scale_max)
	sfx_stream.play()
	sfx_timer = null


func play_ambience_sfx(
	sfx_stream_string: String,
	time_delay: float = 0.0,
	volume_db_min: float = 0.0,
	volume_db_max: float = 0.0,
	pitch_scale_min: float = 1.0,
	pitch_scale_max: float = 1.0):
	
	var sfx_type = get_node_or_null(sfx_stream_string)
	if sfx_type == null:
		print(sfx_stream_string+" not found")
		return
	var sfx_index = randi_range(0,sfx_type.get_child_count()-1)
	var sfx_stream = sfx_type.get_child(sfx_index)
	sfx_stream.volume_db = randf_range(volume_db_min, volume_db_max)
	sfx_stream.pitch_scale = randf_range(pitch_scale_min, pitch_scale_max)
	sfx_stream.play()
	
	#Creates a delay timer
	if time_delay > 0:
		sfx_timer = get_tree().create_timer(time_delay+sfx_stream.stream.get_length())
		await sfx_timer.timeout
	
	sfx_timer = null
	play_ambience_sfx(sfx_stream_string, time_delay, volume_db_min, volume_db_max, pitch_scale_min, pitch_scale_max)


func stop_sfx(sfx_stream_string: String):
	var sfx_type = get_node_or_null(sfx_stream_string)
	if sfx_type == null:
		print(sfx_stream_string+" not found")
		return
	
	for child in sfx_type.get_children():
		if child is AudioStreamPlayer:
			child.stop()
