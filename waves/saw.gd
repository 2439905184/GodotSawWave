extends AudioStreamPlayer

const sample_rate = 22050.0
var frequency = 440.0
var amplitude = 0.5
var phase = 0

var playback: AudioStreamPlayback = null

func _ready():
	self.stream.mix_rate = sample_rate
	playback = get_stream_playback()
	print(playback)
	_fill_buffer()
#	set_process(false)
#	self.play()

func _process(delta):
	_fill_buffer()
	pass

func cal_sawtooth(p_value):
	return amplitude * (2.0 * (p_value - floor(p_value)) - 1.0)

func _fill_buffer():
	var increment = frequency / sample_rate

	var to_fill = playback.get_frames_available()
	while to_fill > 0:
		var frame_value = cal_sawtooth(phase)
		playback.push_frame(Vector2.ONE * frame_value) # Audio frames are stereo.
		phase += increment
		if phase >= 1.0:
			phase -= 1.0
		to_fill -= 1

	pass


func _on_play_pressed():
	self.play()
	pass


func _on_stop_pressed():
	self.stop()
	pass
