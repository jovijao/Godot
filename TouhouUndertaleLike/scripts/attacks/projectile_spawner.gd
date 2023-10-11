class_name ProjectileSpawner extends Node2D

@onready var timer = $Timer

var BULLET = preload("res://instances/projectile/basic_projectile.tscn")

@export var spawnTime = 0.6


func active():
	timer.wait_time = spawnTime
	timer.start(spawnTime)
	timer.autostart = true


func deactive():
	timer.stop()
	timer.autostart = false



func circle_spawn(quantity = 16, radius = 0.0, initialRotation = randi_range(0, 1) * 180, randomInitial = false, forceDir = true, forceInitialDir = true):
	if randomInitial: initialRotation = deg_to_rad(randi_range(0, 90))
	var spacing = 360.0/quantity
	
	for i in range(quantity):
		var bullet = BULLET.instantiate()
		var rot = Vector2(0, 1).rotated( deg_to_rad(spacing * (i+1)) + initialRotation )
		
		bullet.position = position + (rot * radius)
		
		if forceInitialDir: bullet.initialDirection  = rot
		if forceDir: bullet.direction = rot
		
		spawn_projectile(bullet)


func simple_spawn(args = {}):
	var bullet = BULLET.instantiate()
	bullet.position = position
	
	print(args)
	
	if "direction" in args: bullet.direction = args.direction
	if "initialDirection" in args: bullet.initialDirection = args.initialDirection
	
	spawn_projectile(bullet)


func spawn_projectile(bullet):
	if Game.get_encounter().projectiles: Game.get_encounter().projectiles.add_child(bullet)
