class_name Game extends Node

@onready var room = get_child(0)
@onready var encounter = get_child(0)

var ENCOUNTER = preload("res://scenes/encounter.tscn")



static func change_to_encounter():
	var GAME = Globals.get_game()
	GAME.room.queue_free()
	
	GAME.encounter = GAME.ENCOUNTER.instantiate()
	GAME.call_deferred("add_child", GAME.encounter)


static func change_to_room():
	var GAME = Globals.get_game()
	GAME.encounter.queue_free()



static func get_game():
	return Globals.get_game()

static func get_room():
	return Game.get_game().room

static func get_encounter():
	return Game.get_game().encounter
