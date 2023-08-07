extends HBoxContainer

var idx = 0
func _ready():
	pass


func _on_Button_pressed():
	if idx < get_child_count():
		get_child(idx).color = Color("e4c32e")
		for child in get_children():
			if child.get_index() != idx:
				child.color = Color.white
		idx += 1
	if idx == get_child_count():
		idx = 0
	pass # Replace with function body.


func _on_Timer_timeout():
	if idx < get_child_count():
		get_child(idx).color = Color("e4c32e")
		for child in get_children():
			if child.get_index() != idx:
				child.color = Color.white
		idx += 1
	if idx == get_child_count():
		idx = 0
	pass 
