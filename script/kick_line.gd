extends HBoxContainer


func _ready():
	pass
	
func _on_time(idx):
	if get_child(idx).pressed:
		get_tree().current_scene.get_node("kick").play()
