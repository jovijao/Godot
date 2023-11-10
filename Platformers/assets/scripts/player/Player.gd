extends CharacterBody2D

@onready var jump_buffer = $JumpBufferTimer
@onready var coyote_timer = $CoyoteTimer
@onready var dash_timer = $DashTimer
@onready var dash_cooldown_timer = $DashCooldownTimer

@onready var sprite = $Sprite

@export var speed = 120
@export var friction = 20

@export var gravity = 420
@export var jump_force = -180

var dash_effect = load("res://assets/instances/dash_effect.tscn")

var direction = Vector2.ZERO

var jumped = false
var can_jump = true
var can_dash = true

var state = 0

func _physics_process(delta):
	match state:
		0:
			may_walk(delta)
			may_jump()
			apply_gravity(delta)
			
			move_and_slide()
			
			may_dash()
		1:
			velocity = lerp(velocity, direction * 320, 30 * delta) 
			move_and_slide()
			
			if Input.is_action_just_pressed("jump"):
				jump_buffer.start(0.2)


func get_input_direction():
	return Input.get_vector("left", "right", "up", "down")


func apply_gravity(delta):
	velocity.y += gravity * delta


func may_walk(delta):
	var input = get_input_direction()
	
	if input != Vector2.ZERO: 
		direction = input.normalized()
		sprite.flip_h = input.x < 0
	
	velocity.x = lerp(velocity.x, round(input.x) * speed, friction * delta)


func may_jump():
	if Input.is_action_just_pressed("jump"):
		jump_buffer.start(0.2)
	
	if is_on_floor():
		can_jump = true
	elif can_jump and coyote_timer.is_stopped():
		coyote_timer.start(0.2)
	
	if can_jump:
		if not jump_buffer.is_stopped():
			can_jump = false
			velocity.y = jump_force
			if not Input.is_action_pressed("jump"): velocity.y /= 2
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y /= 4


func may_dash():
	if not can_dash: return
	
	if Input.is_action_just_pressed("special"):
		state = 1
		dash_timer.start()
		
		add_child(dash_effect.instantiate())


func _on_coyote_timer_timeout():
	can_jump = false


func _on_dash_timer_timeout():
	state = 0
	velocity.y /= 16
	velocity.x /= 8
	dash_cooldown_timer.start()


func _on_dash_cooldown_timer_timeout():
	can_dash = true
