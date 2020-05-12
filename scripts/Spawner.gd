extends StaticBody2D

func _ready():
	if Globaller.spawnerdirection == "RIGHT":
		$SpawnLocation.global_position = $RIGHT.global_position
	elif Globaller.spawnerdirection == "LEFT":
		$SpawnLocation.global_position = $LEFT.global_position
	elif Globaller.spawnerdirection == "UP":
		$SpawnLocation.global_position = $UP.global_position
	elif Globaller.spawnerdirection == "DOWN":
		$SpawnLocation.global_position = $DOWN.global_position
	pass
	
func _process(_delta):
	$Timer.wait_time = Globaller.spawncooldown

func _on_Timer_timeout():
	spawn_block()
	pass

func spawn_block():
	var obj = load("res://prefabs/" + Globaller.currentspawnerobj + ".tscn")
	var objinstance = obj.instance()
	if Globaller.spawnerdirection == "RIGHT":
		objinstance.global_position = $RightPos.global_position
		$SpawnLocation.global_position = $RIGHT.global_position
	elif Globaller.spawnerdirection == "LEFT":
		objinstance.global_position = $LeftPos.global_position
		$SpawnLocation.global_position = $LEFT.global_position
	elif Globaller.spawnerdirection == "UP":
		objinstance.global_position = $UpPos.global_position
		$SpawnLocation.global_position = $UP.global_position
	elif Globaller.spawnerdirection == "DOWN":
		objinstance.global_position = $DownPos.global_position
		$SpawnLocation.global_position = $DOWN.global_position
	objinstance.modulate = Globaller.objcolor
	if Globaller.staticoption == true:
		objinstance.mode = RigidBody2D.MODE_STATIC
	else:
		objinstance.mode = RigidBody2D.MODE_RIGID
	get_parent().add_child(objinstance)
	$Timer.start()
	pass
	

func _on_SpawnerBlock_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("remove") and !Globaller.currentobj == "Mouse":
		make_input_local(event)
		queue_free()
	pass # Replace with function body.
