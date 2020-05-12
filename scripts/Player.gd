extends Area2D

var dragMouse = false

func _process(delta):
	if(dragMouse):
		global_position = get_viewport().get_mouse_position()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			dragMouse = true
		else:
			dragMouse = false
	pass # Replace with function body.
