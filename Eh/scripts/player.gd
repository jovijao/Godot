extends CharacterBody2D

@onready var objectDetection = $CollisionRay
@onready var interactTimer = $InteractTimer
@onready var collision = $CollisionShape2D

@onready var destinyPos = position
@onready var lastPos = position

@export var speed : float = 64.0

const TILESIZE = 16

var isMoving = false
var canMove = true

var lastState = 0
var state = 0

func _physics_process(delta):
	match state:
		0:
			var input = get_input_vector()
			
			if input != Vector2.ZERO:
				objectDetection.target_position = Vector2(round(input.x), round(input.y)) * TILESIZE
				objectDetection.force_raycast_update()
			
			if Input.is_action_just_pressed("ui_accept"):
				interact()
				return
			
			if input != Vector2.ZERO and not objectDetection.is_colliding():
				if not canMove: return
				lastPos = position
				destinyPos = position + Vector2(round(input.x), round(input.y)) * TILESIZE 
				
				isMoving = true
				change_state(1)
		1:
			var movingDir = (destinyPos - lastPos).normalized()
			collision.global_position = destinyPos
			
			if global_position.distance_to(destinyPos) < (speed * delta):
				global_position = destinyPos
				collision.global_position = global_position
				isMoving = false
				change_state(0)
				return
			
			global_position += movingDir * (speed * delta)


func change_state(newState = 0):
	lastState = state
	state = newState


func interact():
	if not interactTimer.is_stopped(): 
		return false
	
	if objectDetection.get_collider() is InteractiveObject: 
		objectDetection.get_collider().interact(self)
		interactTimer.start()
		return true
	
	return false


func get_input_vector() -> Vector2:
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
	
	return input
