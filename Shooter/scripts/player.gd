extends CharacterBody2D


@onready var bulletSpawnerPos = $BulletSpawner.position
@onready var sprites : CanvasGroup = $Sprites

var BULLET = preload("res://instances/projectiles/basic_projectile.tscn")


var speed = 80.0
var friction = 16.0
var mousePosition = Vector2.ZERO


func _physics_process(delta):
	velocity = lerp(velocity, get_input_vector() * speed, friction * delta)
	mousePosition = get_mouse_relative_position()
	
	for s in sprites.get_children(): s.flip_h = (mousePosition.x > 0)
	
	if Input.is_action_just_pressed("left_click"): shot_bullet()
	
	move_and_slide()

func shot_bullet():
	var bullet : Projectile = BULLET.instantiate()
	var dir = (mousePosition - bulletSpawnerPos).normalized()
	
	
	bullet.global_position = global_position + bulletSpawnerPos + dir * 16
	
	bullet.initialSpeed = 256
	bullet.speed = 128
	
	bullet.initialDirection = dir
	bullet.direction = dir
	
	
	get_parent().add_child(bullet)


func get_mouse_relative_position():
	return get_global_mouse_position() - position


func get_input_vector():
	return Input.get_vector("left", "right", "up", "down")
