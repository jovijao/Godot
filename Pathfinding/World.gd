class_name World extends Node2D

@onready var tiles = $Tiles
@onready var path_finder = $PathFinder 

const tile_size = 32

var TILE = preload("res://instances/tile.tscn")
var tile_textures = [
	load("res://textures/grass.png"), 
	load("res://textures/forest.png"),
	load("res://textures/rock.png"),
	load("res://textures/water.png")
]

var tile_costs = [
	0,
	8,
	42,
	16,
]

var map = [
	[0, 1, 1, 3, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 1, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 1, 3, 3, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 3, 3, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 3, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 2, 2, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 2, 2, 2, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 2, 2, 2, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0]
]

func _ready():
	add_to_group("MAP")
	generate_map()


func generate_map():
	for y in range(map.size()):
		for x in range(map[y].size()):
			create_tile(x, y, map[y][x])

func create_tile(x, y, id):
	var tile = TILE.instantiate()
	tiles.add_child(tile)
	
	tile.position = Vector2(x, y) * tile_size
	tile.texture = tile_textures[id]
	tile.x = x; tile.y = y
	
	tile.pressed.connect(path_finder.receive_path_request)
	

static func get_map():
	return Globals.get_tree().get_first_node_in_group("MAP").map

static func get_tile_cost(id):
	return Globals.get_tree().get_first_node_in_group("MAP").tile_costs[id]
