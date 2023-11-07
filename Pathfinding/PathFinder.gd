extends CharacterBody2D

var directions = [
	Vector2(-1, -1), Vector2(0, -1), Vector2(1, -1),
	Vector2(-1, 0),                 Vector2(1, 0),
	Vector2(-1, 1),  Vector2(0, 1), Vector2(1, 1)
]

var x : int = 0
var y : int = 0

var map = []
var path = []

func _ready():
	await get_tree().create_timer(0.1).timeout
	map = World.get_map()
	print(map)


@warning_ignore("unused_parameter")
func calculate_path(start_position, final_position):
	@warning_ignore("unused_variable")
	var tile_blacklist = []
	@warning_ignore("unused_variable")
	var current_position = start_position
	
	for dir in directions:
		var check_position = dir + start_position
		
		if (check_position.x <= -1 or check_position.x > map[0].size()): continue
		if (check_position.y <= -1 or check_position.x > map.size()): continue
		if (map[check_position.y][check_position.x] == -1): continue
		
		print(check_position)
		
		
		
		

func receive_path_request(dx, dy):
	calculate_path(Vector2(x, y), Vector2(dx, dy))
