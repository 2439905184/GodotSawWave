extends HBoxContainer


signal sync_drum_machine
# dealy
var each_note_time

var idx = -1
onready var timerCtl = get_tree().current_scene.get_node("Timer")
onready var bpmCtl = get_tree().current_scene.get_node("bpm")
onready var player = get_tree().current_scene.get_node("Player")
func _ready():
	each_note_time = 60/bpmCtl.value/4
	timerCtl.wait_time = each_note_time
	timerCtl.connect("timeout",self,"_on_step_pressed")
	connect("sync_drum_machine",get_tree().current_scene.get_node("kick_line"),"_on_time")
	connect("sync_drum_machine",get_tree().current_scene.get_node("clap_line"),"_on_time")
	connect("sync_drum_machine",get_tree().current_scene.get_node("hihat_line"),"_on_time")
	connect("sync_drum_machine",get_tree().current_scene.get_node("snare_line"),"_on_time")
	pass
	

func _on_play_pressed():
	timerCtl.start()
#	bpmCtl.value/16
	pass


func _on_stop_pressed():
	timerCtl.stop()
	pass


func _on_step_pressed():
#	print(get_children())
	if idx < get_child_count():
		idx+=1
		emit_signal("sync_drum_machine",idx)
		
		get_child(idx).get_node("ColorRect").color = Color("e4c32e")
		var current_note = int(get_child(idx).get_node("note").value)
		match current_note:
			0:player.stop()
			1:
				player.frequency = Global.note_table.C
				player.play()
			2:
				player.frequency = Global.note_table.D
				player.play()
			3:
				player.frequency = Global.note_table.E
				player.play()
			4:
				player.frequency = Global.note_table.F
				player.play()
			5:
				player.frequency = Global.note_table.G
				player.play()
			6:
				player.frequency = Global.note_table.A
				player.play()
			7:
				player.frequency = Global.note_table.B
				player.play()
				
		for child in get_children():
#			print("每次遍历",child.get_index())
			if child.get_index() != idx:
				child.get_node("ColorRect").color = Color.white
	if idx == 15:
		idx = -1
	print("每次步进",idx)
	pass


func _on_bpm_value_changed(value):
	print(60/value/4)
	timerCtl.wait_time = 60/value/4
	pass 
