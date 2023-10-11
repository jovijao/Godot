class_name Player extends CharacterBody3D


var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed = 6.4
var friction = 20.0
var jumpForce = 4.2

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = -1.0
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jumpForce
	
	var moveDirection = (transform.basis * Vector3(get_input_dir().x, 0, get_input_dir().y)).normalized()
	
	velocity.x = lerpf(velocity.x, moveDirection.x * speed, friction * delta)
	velocity.z = lerpf(velocity.z, moveDirection.z * speed, friction * delta)
	
	move_and_slide()


func get_input_dir():
	return Input.get_vector("left", "right", "up", "down")
