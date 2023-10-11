extends CharacterBody2D

signal hurt(damage)

var BULLET = preload("res://instances/projectile/player_projectile.tscn")
var SHOTEFFECT = preload("res://instances/effects/bullet_shot_effect.tscn")


var shotTimer = Timer.new()
var autoShotTimer = Timer.new()

@onready var animationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var collision = $Collision

@onready var floorDector : RayCast2D = $FloorDetector

var invincibleTime = 0.8
@onready var invincibleTimer = $Timer
var invicible = false

var defaultSpeed = 64.0
var speed = 64.0
var friction = 32.0

var team = "player"

var state = 0

var jumpBuffer = 0.0

@export var orbitPos = Vector2(0, 0)
@export var orbit = false : set = set_orbit

@export_enum("NORMAL", "PLATFORM") var movementStyle = 0

func _ready():
	add_child(shotTimer)
	shotTimer.one_shot = true
	
	add_child(autoShotTimer)
	autoShotTimer.one_shot = true
	autoShotTimer.timeout.connect(auto_shotter_timeout)

func _physics_process(delta):
	match movementStyle:
		0: move_normal(delta)
		1: move_platform(delta)
	if Input.is_action_just_pressed("shot"): if shotTimer.is_stopped(): shot_bullet_to_mouse()


func move_normal(delta):
	velocity = lerp(velocity, Player.get_input() * speed, friction * delta)
	move_and_slide()

func move_platform(delta):
	var orbitDirection = up_direction
	var rotationFactor = 0
	if orbit:
		orbitDirection = -(orbitPos - position).normalized()
		rotationFactor = deg_to_rad(rad_to_deg(orbitDirection.angle()) + 90)
		
		up_direction = orbitDirection.normalized()
		
		sprite.rotation = rotationFactor
		collision.rotation = rotationFactor
		floorDector.target_position = -(orbitDirection) * 8
	
	
	var baseVelocity = velocity.rotated(-rotationFactor)
	baseVelocity.x = lerpf(baseVelocity.x, Player.get_input().x * speed, friction * delta)
	
	if Input.is_action_pressed("up") and floorDector.get_collider(): baseVelocity.y -= 100
	elif Input.is_action_just_released("up"): baseVelocity.y = max(baseVelocity.y, -20)
	
	baseVelocity.y += (100 + int(Input.is_action_pressed("down")) * 200) * delta 
	baseVelocity.y = clamp(baseVelocity.y, -100, 100)
	
	velocity = baseVelocity.rotated(rotationFactor)
	
	move_and_slide()


func set_orbit(value):
	orbit = value
	
	if not orbit:
		up_direction = Vector2.UP
		
		var rotationFactor = deg_to_rad(rad_to_deg(up_direction.angle()) + 90)
		
		sprite.rotation = rotationFactor
		collision.rotation = rotationFactor
		floorDector.target_position = -up_direction * 8
		
		


func _on_hurtbox_body_entered(body):
	if body.team == team or invicible: return false
	if state != 0: return false
	hurt.emit(body.damage)
	
	sprite.frame = 1
	invincibleTimer.start(invincibleTime)
	animationPlayer.play("hurt")
	invicible = true



func _on_timer_timeout():
	sprite.frame = 0
	invicible = false
	animationPlayer.play("default")

func shot_bullet_to_mouse():
	var bullet = BULLET.instantiate()
	
	var dir = (get_global_mouse_position() - global_position).normalized()
	bullet.direction = dir
	bullet.initialDirection = dir
	
	bullet.position = global_position + dir * 4
	
	var shotEffect = SHOTEFFECT.instantiate()
	
	shotEffect.global_position = global_position + dir * 4
	
	Game.get_encounter().projectiles.add_child(bullet)
	Game.get_encounter().projectiles.add_child(shotEffect)
	
	speed = 36.0
	
	shotTimer.start(0.2)
	autoShotTimer.start(0.45)

func auto_shotter_timeout():
	speed = defaultSpeed
	if Input.is_action_pressed("shot") and shotTimer.is_stopped(): shot_bullet_to_mouse()
