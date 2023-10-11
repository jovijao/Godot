extends Node

var PLAYER = preload("res://instances/player/player.tscn")

var INSTANCES = {
	"darknessFade": preload("res://instances/interface/effects/darknessFade.tscn"),
	"darknessUnfade": preload("res://instances/interface/effects/darknessUnfade.tscn")
}

var SCREENS = {
	"dialog": preload("res://instances/interface/dialog.tscn")
}

var TIMELINES = {
	"test": {
		"settings": {},
		"dialogs": [
			{
				"text": "teste...."
			}
		]
	}
}

var ROOMS = {
	"test": "res://scenes/rooms/roomTest2.tscn",
	"test2": "res://scenes/rooms/roomTest.tscn",
}


func get_screen(screen):
	if screen in SCREENS: return SCREENS[screen].instantiate()
	return null

func get_instance(instance):
	if instance in INSTANCES: return INSTANCES[instance].instantiate()
	return null

func get_timeline(timeline):
	if timeline in TIMELINES: return TIMELINES[timeline]
	return {"settings": {}, "dialogs": [] }
