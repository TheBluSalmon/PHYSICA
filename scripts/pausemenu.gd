extends Control

signal OpenObjProperties

var can_pause = true
var fullscreenoption

onready var FPSCount = get_parent().get_node("FpsCount")
onready var OBJCount = get_parent().get_node("ObjectCount")

func _process(delta):
	if get_parent().get_node("Startup").visible:
		can_pause = false
	else:
		can_pause = true
	FPSCount.text = "FPS: " + String(Engine.get_frames_per_second())
	var spawnedobjects = get_tree().get_nodes_in_group("Object").size()
	OBJCount.text = "OBJECTS: " + String(spawnedobjects)
	
func _ready():
	FPSCount.visible = false
	OBJCount.visible = false
	if OS.window_fullscreen == true:
		fullscreenoption = true
	else:
		fullscreenoption = false


func _input(event):
	if event.is_action_pressed("pause") and can_pause:
		visible = not visible
		get_tree().paused = not get_tree().paused
		if (get_tree().paused):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _on_CUBE_pressed():
	Globaller.currentobj = "Cube"
	pass # Replace with function body.


func _on_SPHERE_pressed():
	Globaller.currentobj = "Sphere"
	pass # Replace with function body.


func _on_DRAG_pressed():
	Globaller.currentobj = "Mouse"
	pass # Replace with function body.


func _on_HUMANOID_pressed():
	Globaller.currentobj = "Humanoid"
	pass # Replace with function body.


func _on_CLEAR_pressed():
	for object in get_tree().get_nodes_in_group("Object"):
		object.queue_free()


func _on_CheckButton_toggled(button_pressed):
	if button_pressed == true:
		Globaller.staticoption = true
	else:
		Globaller.staticoption = false
	pass # Replace with function body.


func _on_SLANTED_pressed():
	Globaller.currentobj = "SlantedTile"
	pass # Replace with function body.


func _on_PROPERTIES_pressed():
	can_pause = false
	emit_signal("OpenObjProperties")
	visible = false
	pass # Replace with function body.


func _on_Properties_CloseObjProperties():
	can_pause = true
	visible = true
	pass # Replace with function body.


func _on_SPAWNER_pressed():
	Globaller.currentobj = "Spawner"


func _on_GlowOption_toggled(button_pressed):
	var Env = get_tree().get_nodes_in_group("WorldEnv")
	for WorldEnv in Env:
		if button_pressed == true:
			WorldEnv.environment.glow_enabled = true
		elif button_pressed == false:
			WorldEnv.environment.glow_enabled = false


func _on_FullScreenOption_toggled(button_pressed):
	if button_pressed == true:
		fullscreenoption = true
		OS.window_fullscreen = true
	elif button_pressed == false:
		fullscreenoption = false
		OS.window_fullscreen = false

func _on_DebugOption_toggled(button_pressed):
	if button_pressed == true:
		FPSCount.visible = true
		OBJCount.visible = true
	else:
		FPSCount.visible = false
		OBJCount.visible = false
	pass # Replace with function body.


func _on_QUIT_pressed():
	get_tree().quit()
	pass # Replace with function body.
