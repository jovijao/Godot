extends Node2D

var shotrays : Array[RayCast2D] = []

@export var direction : Vector2 = Vector2.DOWN
@export var quantity : int = 1
@export var spread : float = 0.0
@export var distance : float = 3840.0


func set_spread(value): spread = deg_to_rad(value); return self
func set_quantity(value): quantity = value; return self
func set_direction(value): direction = value; return self
func set_distance(value): distance = value; return self


func execute(origin = global_position):
	global_position = origin
	
	for q in range(quantity):
		var raycast = RayCast2D.new()
		add_child(raycast)
		
		raycast.set_collision_mask_value(6, true)
		raycast.collide_with_areas = true
		raycast.hit_from_inside = true
		
		shotrays.append(raycast)
	
	for shot in shotrays:
		shot.target_position = (direction).rotated(randf_range(-spread, spread)) * distance
		shot.force_raycast_update()
		
		var shotPoint = shot.global_position + shot.target_position
		
		if shot.get_collider() != null: 
			shotPoint = shot.get_collision_point()
			if shot.get_collider() is Hurtbox: shot.get_collider().get_hurt(1, shotPoint)
		
		summon_bullet_trail(shot.global_position, shotPoint)
	
	
	queue_free()


func summon_bullet_trail(start = global_position, end = global_position):
	var bulletTrail = ResourceManager.get_instance("bulletTrail")
	get_parent().add_child(bulletTrail)
	bulletTrail.draw_trail(start, end)
