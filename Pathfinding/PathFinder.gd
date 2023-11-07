extends CharacterBody2D

var directions = [
	Vector2(-1, -1), Vector2(0, -1), Vector2(1, -1),
	Vector2(-1, 0),                 Vector2(1, 0),
	Vector2(-1, 1),  Vector2(0, 1), Vector2(1, 1)
]

var direction_costs = [
	14, 10, 14,
	10,     10,
	14, 10, 14
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
	var _tile_blacklist = []
	
	var d = final_position - start_position
	var distance = (d.x + d.y) * 10
	
	var current_position = start_position
	var last_check_cost = distance
	
	print("start position: %s" % start_position)
	print("final position: %s" % final_position)
	print("distance: %s" % distance)
	
	var tries = 8
	while (tries > 0):
		for dir in directions:
			var check_position = dir + start_position
			
			if (check_position.x <= -1 or check_position.x > map[0].size()): continue
			if (check_position.y <= -1 or check_position.x > map.size()): continue
			if (map[check_position.y][check_position.x] == -1): continue
			
			var cost = get_direction_cost(dir) + World.get_tile_cost(map[check_position.y][check_position.x])
			
			print("checkig position: %s \ncost: %s" % [check_position, cost])
			
			if last_check_cost > (distance - cost):
				current_position = check_position
				
				position = check_position * 32
				await get_tree().create_timer(0.1).timeout
				
				if current_position == final_position: break
				
		tries -= 1
	
	print(current_position)
	x = current_position.x
	y = current_position.y

func receive_path_request(dx, dy):
	calculate_path(Vector2(x, y), Vector2(dx, dy))

func get_direction_cost(direction):
	match direction:
		Vector2(-1, -1), Vector2(1, -1), Vector2(-1, 1), Vector2(1, 1):
			return 14
		_:  return 10
