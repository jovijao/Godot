class_name Projectile extends CharacterBody2D

@export var target : CharacterBody2D = null

@export var damage : int = 1
@export var knockback : float = 0.0

@export var direction = Vector2.DOWN
@export var initialDirection = Vector2.DOWN
var wavyDirection = Vector2.ZERO

@export var spread : float = 0.0
@export var aimTargetOnSpawn = false
@export var targetPosition : Vector2

@export var lifeTime : float = 8.0

@export var gravity = 0.0
@export var gravityDir = Vector2.DOWN

@export_category("MOVEMENT")

@export var team = "enemy"

enum MOVEMENT {
	NORMAL,
	LINEAR,
	WAVE,
	NONE
}

@export var movementType = MOVEMENT.NORMAL

@export var speed = 64.0
@export var initialSpeed = 64.0

@export var randomSpeed = false
@export var randomSpeedMaxRange = 96.0

@export var friction = 8.0

@export_category("IMPACT")
@export var bounce = false
@export var destroyOnHit = true
@export var collide = false

@export_category("WAVE")
@export var waveMovement = false

@export var waveFrequency = 0.075
@export var waveAmplitude = 64

func _ready():
	set_collision_layer_value(1, false)
	
	if collide: set_collision_mask_value(1, true)
	else:  set_collision_mask_value(1, false)
	
	set_collision_layer_value(6, true)
	set_collision_mask_value(5, true)
	
	randomize()
	
	modifier_check()
	
	if randomSpeed: speed = randi_range(speed, randomSpeedMaxRange)
	velocity = initialDirection * initialSpeed


func _physics_process(delta):
	if get_slide_collision_count(): 
		var collision = get_slide_collision(0)
		
		if destroyOnHit:
			queue_free()
		
		if bounce: 
			var bounceAngle = (velocity.angle() + collision.get_angle())
			
			direction = direction.rotated(bounceAngle)
			velocity = velocity.rotated(-bounceAngle)
	
	
	match movementType:
		MOVEMENT.NORMAL:
			velocity = lerp(velocity, direction * speed, friction * delta)
		MOVEMENT.LINEAR:
			velocity = direction * speed
		MOVEMENT.WAVE:
			move_wavy(delta)
	
	
	velocity += gravityDir * gravity * delta
	
	move_and_slide()

func modifier_check():
	direction = direction.rotated( deg_to_rad( randf_range(-spread, spread) ) )
	
	if aimTargetOnSpawn: direction = (targetPosition - global_position).normalized() 
	
	if lifeTime > 0.0: 
		var timer = Timer.new(); timer.timeout.connect(queue_free); add_child(timer); timer.start(lifeTime)


func move_wavy(delta, amplitude = waveAmplitude, frequency = waveFrequency):
	wavyDirection.x += speed * delta
	wavyDirection.y = amplitude * sin(frequency * wavyDirection.x)
	velocity = wavyDirection
	velocity = velocity.rotated(direction.angle())

