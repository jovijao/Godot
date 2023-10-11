class_name Player extends CharacterBody2D

var speed = 128.0
var friction = 32.0

func _physics_process(delta):
	velocity = lerp(velocity, Player.get_input() * (speed - (friction/2 * clamp(speed, 0, 1))), friction * delta)
	move_and_slide()

static func get_input(): 
	return Input.get_vector("left", "right", "up", "down").normalized()
