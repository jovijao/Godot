class_name Game extends Node

@onready var room = get_child(0)


@warning_ignore("unused_parameter")
func load_room(roomName):
	
	if roomName in ResourceManager.ROOMS: 
		room = load(ResourceManager.ROOMS[roomName]).instantiate() 
		add_child(room)
	
	return true

func unload_room():
	if room != null: 
		room.queue_free()
		return true
	return false


static func get_game():
	return Globals.get_game()

static func get_room():
	return Game.get_game().room



@warning_ignore("unused_parameter")
static func change_room(roomName):
	var GAME : Game = Globals.get_game()
	
	GAME.unload_room()
	GAME.load_room(roomName)
