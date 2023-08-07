extends AudioStreamPlayer

const sample_rate = 22050.0
var frequency = 440.0
var amplitude = 0.5
var phase = 0

var playback: AudioStreamPlayback = null

func _ready():
	self.stream.mix_rate = sample_rate
	playback = get_stream_playback()
	_fill_buffer()
	self.play()

func _process(delta):
	_fill_buffer()

func cal_square(p_value):
	if p_value < 0:
		return -amplitude
	else:
		return amplitude

func _fill_buffer():
	var increment = frequency / sample_rate

	var to_fill = playback.get_frames_available()
	while to_fill > 0:
		var frame_value = cal_square(phase)
		playback.push_frame(Vector2.ONE * frame_value) # Audio frames are stereo.
		phase = fmod(phase + increment, 1.0) - 0.5
		to_fill -= 1

	pass
