extends CharacterBody2D

@onready var jump_buffer = $JumpBufferTimer
@onready var coyote_timer = $CoyoteTimer
@onready var dash_timer = $DashTimer
@onready var dash_cooldown_timer = $DashCooldownTimer

@onready var sprite = $Sprite

@export var run_speed = 280
@export var walk_speed = 140
@onready var speed : float = run_speed
@export var default_friction : float = 16
var friction : float = default_friction

@export var gravity : float = 420
@export var jump_force : float = -180

var dash_effect = load("res://assets/instances/dash_effect.tscn")

var direction = Vector2.ZERO

var jumped : bool = false
var can_jump : bool = true
var can_dash : bool = true

var dash_quantity : int = 1
var dashs_left = dash_quantity

var state : int = 0

const max_fall_speed : float = 500
const max_ascend_speed : float = -500

func _physics_process(delta):
	match state:
		0:
			may_walk(delta)
			may_wall_jump()
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
	
	velocity.y = clamp(velocity.y, max_ascend_speed, max_fall_speed)


func may_walk(delta):
	var input = get_input_direction()
	var extra_speed = max(0, velocity.length() - speed)
	
	print(
		"Speed: %s, \nExtra speed: %s" %
		
		[ velocity.length(),
		extra_speed])
	
	if input != Vector2.ZERO: 
		direction = input.normalized()
		sprite.flip_h = input.x < 0
	
	if is_on_floor(): friction = lerpf(friction, default_friction, 8 * delta)
	else:             friction = lerpf(friction, default_friction/4, 4 * delta)
	
	velocity.x = lerp(velocity.x, round(input.x) * speed + + extra_speed, friction * delta)


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
			jump_buffer.stop()
			if not Input.is_action_pressed("jump"): velocity.y /= 2
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y /= 4


func may_wall_jump():
	if is_on_floor(): return
	if not can_wall_jump(): return
	
	if not jump_buffer.is_stopped(): 
		velocity.y = jump_force * 0.8
		velocity.x = - direction.x * 480
		
		can_jump = false
		jump_buffer.stop()

func may_dash():
	if not can_dash: return
	
	if is_on_floor():
		dashs_left = dash_quantity
	
	if dashs_left == 0: return
	
	if Input.is_action_just_pressed("downwards_dash"):
		if is_on_floor(): return
		direction = Vector2.DOWN + Vector2(round(direction.x), 0)
		dashs_left -= 1
		state = 1
		can_jump = false
		
		dash_timer.start()
		
		add_child(dash_effect.instantiate())
		
	
	if Input.is_action_just_pressed("frontwards_dash"):
		if Input.is_action_pressed("up"): direction = Vector2(0, -0.6)
		else: direction = Vector2(round(direction.x), -0.2)
		
		dashs_left -= 1
		state = 1
		can_jump = false
		
		dash_timer.start()
		
		add_child(dash_effect.instantiate())

func can_wall_jump():
	return ($RayCastWallLeft.is_colliding() or $RayCastWallRight.is_colliding()) and is_on_wall() 


func _on_coyote_timer_timeout():
	can_jump = false

func _on_dash_timer_timeout():
	state = 0
	dash_cooldown_timer.start()
	can_dash = false

func _on_dash_cooldown_timer_timeout():
	can_dash = true
