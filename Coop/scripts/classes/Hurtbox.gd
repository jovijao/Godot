class_name Hurtbox extends Area2D

signal hurt(damage, direction)

func _init():
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	
	
	set_collision_layer_value(6, true)
	set_collision_mask_value(7, true)


func get_hurt(damage, origin):
	hurt.emit(damage, (origin - global_position).normalized())
