extends AudioStreamGenerator

var frequency = 440
var amplitude = 0.5
var phase = 0

func _mix_buffer(samples):
	var sample_rate = get_mix_rate()
	var buffer_size = samples.size() # 获取缓冲区大小
	var increment = frequency / sample_rate # 计算每个样本的频率增量

	for i in range(buffer_size):
		# 生成锯齿波形样本
		samples[i] = amplitude * ((phase % 1) * 2 - 1)
		phase += increment
