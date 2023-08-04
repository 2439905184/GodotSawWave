extends AudioStreamPlayer

const sample_rate = 22050.0
var frequency = 440.0
var amplitude = 0.5
var phase = 0

var playback: AudioStreamPlayback = null

var index = 0

func _ready():
	self.stream.mix_rate = sample_rate
	playback = get_stream_playback()
	_fill_buffer()
	self.play()
	
func _process(delta):
	_fill_buffer()
	index += 1 
	
func cal_saw(p_value):
	return amplitude * sin(p_value)
	
func _fill_buffer():
	var increment = frequency / sample_rate

	var to_fill = playback.get_frames_available()
	while to_fill > 0:
		playback.push_frame(Vector2.ONE * phase) # Audio frames are stereo.
		phase = fmod(phase + increment, 2.0)
		to_fill -= 1
	print(phase)
