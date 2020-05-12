extends RigidBody2D

var dragMouse = false

func _ready():
	if !is_in_group("Humanoid"):
		change_size(Globaller.objectsizex, Globaller.objectsizey)
	if !Globaller.staticoption:
		linear_velocity = Globaller.lineardirection * Globaller.linearspeed

func _process(delta):
	if(dragMouse):
		if Input.is_action_pressed("rotate"):
			rotation_degrees += Globaller.rot_speed
		elif Input.is_action_pressed("counterrotate"):
			rotation_degrees -= Globaller.rot_speed
		global_position = get_viewport().get_mouse_position()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && Globaller.currentobj == "Mouse":
		make_input_local(event)
		if event.is_pressed():
			dragMouse = true
		else:
			dragMouse = false
	elif event.is_action_pressed("remove") and !Globaller.currentobj == "Mouse":
		make_input_local(event)
		queue_free()
	pass # Replace with function body.

func change_size(xvalue, yvalue):
	$Sprite.scale = Vector2(xvalue, yvalue)
	$CollisionShape2D.scale = Vector2(xvalue, yvalue)
	$Area2D.scale = Vector2(xvalue, yvalue)
	pass
