class_name Hitbox extends Area2D

func _init():
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	
	set_collision_layer_value(6, true)
	set_collision_mask_value(5, true)
	
