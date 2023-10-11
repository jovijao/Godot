class_name Hurtbox extends Area2D

func _init():
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	
	set_collision_layer_value(5, true)
	set_collision_mask_value(6, true)
	
	


func _on_hurtbox_hit(hitbox):
	if not hitbox is Hitbox: return
