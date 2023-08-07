extends AudioStreamPlayer

const sample_rate = 22050.0
var frequency = 440.0
var amplitude = 0.5
var phase = 0

var playback: AudioStreamPlayback = null

var attack_time = 0.1
var decay_time = 0.1
var sustain_level = 0.3
var release_time = 0.3
var envelope = 0.0

enum EnvelopeState {
	ATTACK,
	DECAY,
	SUSTAIN,
	RELEASE
}

var current_state = EnvelopeState.ATTACK
var elapsed_time = 0.0

func _ready():
	self.stream.mix_rate = sample_rate
	playback = get_stream_playback()
	_fill_buffer()
#	self.play()

func _process(delta):
	_fill_buffer()

#func envelope_adsr(delta):
#	match current_state:
#		EnvelopeState.ATTACK:
#			#持续时间
#			elapsed_time += delta
#			envelope = elapsed_time / attack_time
#			if elapsed_time >= attack_time:
#				elapsed_time = 0.0
#				current_state = EnvelopeState.DECAY
#				envelope = 1.0
#		EnvelopeState.DECAY:
#			elapsed_time += delta
#			envelope = 1.0 - ((elapsed_time / decay_time) * (1.0 - sustain_level))
#			if elapsed_time >= decay_time:
#				elapsed_time = 0.0
#				current_state = EnvelopeState.SUSTAIN
#				envelope = sustain_level
#		EnvelopeState.RELEASE:
#			elapsed_time += delta
#			envelope = (1.0 - (elapsed_time / release_time)) * sustain_level
#			if elapsed_time >= release_time:
#				elapsed_time = 0.0
#				current_state = EnvelopeState.ATTACK
#				envelope = 0.0
				
func cal_vol_env():
	var value = 0.0
	for i in 200:
		value += 0.01
	print(value)
	return value
	pass
func cal_square(p_value):
	if p_value < 0:
		return -amplitude
	else:
		return amplitude

func _fill_buffer():
	var increment = frequency / sample_rate

	var to_fill = playback.get_frames_available()
	while to_fill > 0:
#		envelope_adsr(1.0 / sample_rate)
#		var change_value = cal_vol_env()
		var frame_value = cal_square(phase)
		playback.push_frame(Vector2.ONE * frame_value) # Audio frames are stereo.
		phase += increment
		if phase >= 1.0:
			phase -= 2.0
		to_fill -= 1

	pass
	
func _on_play_pressed():
	self.play()
	pass


func _on_stop_pressed():
	self.stop()
	pass

