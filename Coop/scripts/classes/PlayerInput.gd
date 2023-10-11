class_name PlayerInput extends Node

static func get_vector(player = 0):
	return Input.get_vector( str(player) + "left", str(player) + "right", str(player) + "up", str(player) + "down")

static func is_action_pressed(player = 0, input = ""):
	return Input.is_action_pressed(str(player) + input)
	
static func is_action_just_pressed(player = 0, input = ""):
	return Input.is_action_just_pressed(str(player) + input)

static func is_action_just_released(player = 0, input = ""):
	return Input.is_action_just_released(str(player) + input)
