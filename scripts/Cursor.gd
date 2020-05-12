extends Area2D

var is_touching_body = false
var holding = false
var point
var target
var arrow_drag = true
export var traillength = 0
export(NodePath) var targetPath
onready var detector = $Detector

func _ready():
	$Line2D.visible = false
	target = get_node(targetPath)
	$Cursor.texture = load("res://assets/Cursor/cursornormal.png")
	
func _process(delta):
	$Cube.scale = Vector2(Globaller.objectsizex, Globaller.objectsizey)
	$Sphere.scale = Vector2(Globaller.objectsizex, Globaller.objectsizey)
	$SlantTile.scale = Vector2(Globaller.objectsizex, Globaller.objectsizey)
	if Globaller.currentobj == "Spawner":
		$Cube.scale = Vector2(1, 1)
	$Line2D.global_position = Vector2(0,0)
	$Line2D.global_rotation = 0
	point = target.global_position
	$Line2D.add_point(point)
	
	if Globaller.currentobj == "Mouse":
		show_drag_cursor()
		arrow_drag = true
	else:
		arrow_drag = false
		if Globaller.currentobj == "Cube":
			show_cube_cursor()
		elif Globaller.currentobj == "Sphere":
			show_sphere_cursor()
		elif Globaller.currentobj == "Humanoid":
			show_humanoid_cursor()
		elif Globaller.currentobj == "SlantedTile":
			show_slant_cursor()
		elif Globaller.currentobj == "Spawner":
			show_cube_cursor()
		
	while $Line2D.get_point_count() > traillength:
		$Line2D.remove_point(0)
	
	global_position = get_viewport().get_mouse_position()
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if arrow_drag == true:
			if !body.is_in_group("Untouchable") && Globaller.currentobj == "Mouse":
				if Input.is_action_pressed("hold"):
					$Line2D.visible = true
					$Cursor.texture = load("res://assets/Cursor/cursorarm.png")
				else:
					$Line2D.visible = false
					$Cursor.texture = load("res://assets/Cursor/cursornormal.png")
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("install"):
		if Globaller.currentobj == "Cube":
			var cube = load("res://prefabs/Cube.tscn")
			var cubeinstance = cube.instance()
			cubeinstance.global_position = global_position
			cubeinstance.rotation = rotation
			cubeinstance.modulate = Globaller.objcolor
			if Globaller.staticoption == true:
				cubeinstance.mode = RigidBody2D.MODE_STATIC
			else:
				cubeinstance.mode = RigidBody2D.MODE_RIGID
			get_parent().add_child(cubeinstance)
		elif Globaller.currentobj == "Sphere":
			var sphere = load("res://prefabs/Sphere.tscn")
			var sphereinstance = sphere.instance()
			sphereinstance.global_position = global_position
			sphereinstance.rotation = rotation
			sphereinstance.modulate = Globaller.objcolor
			if Globaller.staticoption == true:
				sphereinstance.mode = RigidBody2D.MODE_STATIC
			else:
				sphereinstance.mode = RigidBody2D.MODE_RIGID
			get_parent().add_child(sphereinstance)
		elif Globaller.currentobj == "Humanoid":
			var humanoid = load("res://prefabs/RagdollHumanoid.tscn")
			var humanoidinstance = humanoid.instance()
			humanoidinstance.global_position = global_position
			humanoidinstance.rotation = rotation
			humanoidinstance.modulate = Globaller.objcolor
			if Globaller.staticoption == true:
				humanoidinstance.mode = RigidBody2D.MODE_STATIC
			else:
				humanoidinstance.mode = RigidBody2D.MODE_RIGID
			get_parent().add_child(humanoidinstance)
		elif Globaller.currentobj == "SlantedTile":
			var slantedtile = load("res://prefabs/SlantedObject.tscn")
			var slantinstance = slantedtile.instance()
			slantinstance.global_position = global_position
			slantinstance.modulate = Globaller.objcolor
			if Globaller.staticoption == true:
				slantinstance.mode = RigidBody2D.MODE_STATIC
			else:
				slantinstance.mode = RigidBody2D.MODE_RIGID
			get_parent().add_child(slantinstance)
		elif Globaller.currentobj == "Spawner":
			var spawnertile = load("res://prefabs/Spawner.tscn")
			var spawnerinstance = spawnertile.instance()
			spawnerinstance.global_position = global_position
			spawnerinstance.modulate = Globaller.objcolor
			get_parent().add_child(spawnerinstance)
			
func show_drag_cursor():
	$Cursor.visible = true
	$Sphere.visible = false
	$Cube.visible = false
	$Humanoid.visible = false
	$SlantTile.visible = false

func show_sphere_cursor():
	$Cursor.visible = false
	$Sphere.visible = true
	$Cube.visible = false
	$Humanoid.visible = false
	$SlantTile.visible = false
	
func show_cube_cursor():
	$Cursor.visible = false
	$Sphere.visible = false
	$Cube.visible = true
	$Humanoid.visible = false
	$SlantTile.visible = false

func show_humanoid_cursor():
	$Cursor.visible = false
	$Sphere.visible = false
	$Cube.visible = false
	$Humanoid.visible = true
	$SlantTile.visible = false
	
func show_slant_cursor():
	$Cursor.visible = false
	$Sphere.visible = false
	$Cube.visible = false
	$Humanoid.visible = false
	$SlantTile.visible = true

