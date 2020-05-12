extends Control


func _ready():
	get_tree().paused = true
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func _on_Begin_pressed():
	get_tree().paused = false
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_ItchLink_pressed():
	OS.shell_open("https://simonknowsstuff.itch.io")
	pass # Replace with function body.
