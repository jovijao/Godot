class_name Arena extends Node2D

signal round_finished

@onready var soulHandle = $SoulHandle
@onready var attacks = $Attacks
@onready var projectiles = $Projectiles
@onready var arenaCollision = $Collision

var SOUL = preload("res://instances/encounter/soul.tscn")
var soul = null



func start_round():
	return spawn_soul()


func finish_round():
	despawn_player()
	remove_attacks()
	
	round_finished.emit()


@warning_ignore("unused_parameter")
func set_arena_bounds(topLeft : Vector2 = Vector2(-192, -104), bottomRight : Vector2 = Vector2(192, 112)):
	arenaCollision.get_child(0).position.y = topLeft.y 
	arenaCollision.get_child(1).position.x = topLeft.x
	arenaCollision.get_child(2).position.y = bottomRight.y
	arenaCollision.get_child(3).position.x = bottomRight.x



func spawn_soul():
	despawn_player()
	
	soul = SOUL.instantiate()
	soulHandle.add_child(soul)
	
	return soul

func despawn_player():
	if soul != null: soul.queue_free()
	return true


func add_attack(attack):
	attacks.add_child(attack)


func remove_attacks():
	for attack in attacks.get_children():
		attack.queue_free()
