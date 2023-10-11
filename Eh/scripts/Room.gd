class_name Room extends Node2D

var player = null

func _ready():
	spawn_player()

func spawn_player():
	if player != null: player.queue_free()
	player = ResourceManager.PLAYER.instantiate()
	add_child(player)
	return true
