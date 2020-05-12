extends Node2D


func _input(event):
	if event.is_action_pressed("down"):
		rotation_degrees += 60
