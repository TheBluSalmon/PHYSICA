extends Control

signal CloseObjProperties

var cangoback = false

onready var colorpicker = $ColorPicker
onready var rotationindicator = $RotationIndicator
onready var rot_speed_slider = $RotationSpeed
onready var linearindicator = $LinearIndicator
onready var linearslider = $LinearValue
onready var lineardirectiondrop = $LinearDropdown
onready var spawnerdropdown = $SpawnerDropdown
onready var spawnerobject = $SpawnerObject

func _ready():
	visible = false
	
func _process(delta):
	if Globaller.currentobj == "Cube":
		$Preview.texture = load("res://assets/player.png")
	elif Globaller.currentobj == "Sphere":
		$Preview.texture = load("res://assets/Sphere.png")
	elif Globaller.currentobj == "SlantedTile":
		$Preview.texture = load("res://assets/slanttile.png")
	
	Globaller.objcolor = colorpicker.color
	Globaller.rot_speed = rot_speed_slider.value
	Globaller.linearspeed = linearslider.value
	rotationindicator.text = "Rotation Speed: " + String(Globaller.rot_speed)
	linearindicator.text = "Initial Velocity: " + String(Globaller.linearspeed)
	if lineardirectiondrop.selected == 0:
		Globaller.lineardirection = Vector2.UP
	elif lineardirectiondrop.selected == 1:
		Globaller.lineardirection = Vector2.DOWN
	elif lineardirectiondrop.selected == 2:
		Globaller.lineardirection = Vector2.LEFT
	elif lineardirectiondrop.selected == 3:
		Globaller.lineardirection = Vector2.RIGHT
		
	if spawnerdropdown.selected == 0:
		Globaller.spawnerdirection = "UP"
	elif spawnerdropdown.selected == 1:
		Globaller.spawnerdirection = "DOWN"
	elif spawnerdropdown.selected == 2:
		Globaller.spawnerdirection = "LEFT"
	elif spawnerdropdown.selected == 3:
		Globaller.spawnerdirection = "RIGHT"
		
	if spawnerobject.selected == 0:
		Globaller.currentspawnerobj= "Cube"
	elif spawnerobject.selected == 1:
		Globaller.currentspawnerobj = "Sphere"
	elif spawnerobject.selected == 2:
		Globaller.currentspawnerobj = "RagdollHumanoid"
	elif spawnerobject.selected == 3:
		Globaller.currentspawnerobj = "SlantedObject"
	
	Globaller.spawncooldown = $SpawnCooldown.value
	$SpawnerLabel4.text = "Spawn Cooldown: " + String(Globaller.spawncooldown)
	
	Globaller.objectsizex = $PreviewHSlider.value
	Globaller.objectsizey = $PreviewYSlider.value
	$Preview.scale = Vector2(Globaller.objectsizex, Globaller.objectsizey)
	$Preview.modulate = Globaller.objcolor
	
func _on_Inventory_OpenObjProperties():
	visible = true
	cangoback = true
	pass # Replace with function body.


func _on_BACK_pressed():
	visible = false
	emit_signal("CloseObjProperties")
	pass # Replace with function body.
	
func _input(event):
	if event.is_action_pressed("pause") and cangoback == true:
		visible = false
		emit_signal("CloseObjProperties")
		cangoback = false
