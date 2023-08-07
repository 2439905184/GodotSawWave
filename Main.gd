extends Node2D

var use_keyboard_as_midi = false

var idx = 0 
func _ready():
	$play.connect("pressed",$Player,"_on_play_pressed")
	$stop.connect("pressed",$Player,"_on_stop_pressed")
	
	$Timer.connect("timeout",$kick_line,"_on_time")
	$Timer.connect("timeout",$clap_line,"_on_time")
	$Timer.connect("timeout",$hihat,"_on_time")
	$Timer.connect("timeout",$snare,"_on_time")
	
	pass


func _on_square_pressed():
	$Player.set_script(load("res://waves/square.gd").new())
#	print($Player.get_script())
	pass


func _on_saw_pressed():
	$Player.set_script(load("res://waves/saw.gd").new())
#	print($Player.get_script())
	pass


func _on_keyboard_toggled(button_pressed):
	use_keyboard_as_midi = button_pressed
	pass
	
func _input(event):
	if event is InputEventKey and use_keyboard_as_midi:
		match event.scancode:
			KEY_Z:
				$Player.frequency = Global.note_table.C
				$Player.play()
			KEY_X:
				$Player.frequency = Global.note_table.D
				$Player.play()
			KEY_C:
				$Player.frequency = Global.note_table.E
				$Player.play()
			KEY_V:
				$Player.frequency = Global.note_table.F
				$Player.play()
			KEY_B:
				$Player.frequency = Global.note_table.G
				$Player.play()
			KEY_N:
				$Player.frequency = Global.note_table.A
				$Player.play()
			KEY_M:
				$Player.frequency = Global.note_table.B
				$Player.play()
		
		pass
