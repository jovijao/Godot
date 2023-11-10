class_name Game extends Node

var level = null
var level_name = ""

func _ready():
	Game.load_level("test")

static func get_game():
	return Globals.get_tree().current_scene

static func load_level(load_level_name = "test"):
	var loading_level = load("res://scenes/levels/%s.tscn" % load_level_name).instantiate()
	var game = Game.get_game()
	
	game.level_name = load_level_name
	game.level = loading_level
	game.add_child(loading_level)
	
	
