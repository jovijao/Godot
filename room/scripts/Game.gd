class_name Game extends Node

signal game_ready(game)

func _ready():
	initialize()
	game_ready.emit(self)

func initialize():
	pass

static func get_game() -> Game:
	return Globals.get_game()

static func get_room():
	Game.get_game()
