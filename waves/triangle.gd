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

func cal_triangle(p_value):
	var normalized_phase = (p_value + 1.0) / 2.0
	if normalized_phase < 0.5:
		return amplitude * (normalized_phase - 0.25)
	else:
		return amplitude * (0.75 - normalized_phase)

func _fill_buffer():
	var increment = frequency / sample_rate

	var to_fill = playback.get_frames_available()
	while to_fill > 0:
		var frame_value = cal_triangle(phase)
		playback.push_frame(Vector2.ONE * frame_value) # Audio frames are stereo.
		phase = fmod(phase + increment, 2.0) - 1.0
		to_fill -= 1

	pass
