extends Node

@onready var soul = Encounter.get_soul()


var patterns = [
	{
		"method": "simple_spawn",
		"position": Vector2(100, 100),
		"direction": "player",
		"initialDirection": "player",
		"timer": 0.4,
		"spawner": ProjectileSpawner.new(),
	}
]

var index = 0
var repeats = 0

var patternTimer : Timer = Timer.new()


func _ready():
	add_child(patternTimer)
	patternTimer.timeout.connect(pattern_timer_timeout)
	
	call_pattern()

func check_direction(dir, pos = Vector2.ZERO):
	if dir is String: 
		if soul: return (soul.global_position - pos).normalized()
		else: return Vector2.ZERO
		
	return dir

func check_origin(origin):
	if origin is String: match origin:
		"enemy":
			return Vector2.ZERO
		
	
	return origin

func call_pattern():
	var pattern = patterns[index]
	
	if not is_instance_valid(pattern.spawner):
		add_child(pattern.spawner)
	
	var args = {}
	
	pattern.spawner.position = pattern.position
	
	if "direction" in pattern: args["direction"] = check_direction(pattern["direction"], pattern.position)
	if "initialDirection" in pattern: args["initialDirection"] = check_direction(pattern["initialDirection"], pattern.position) 
	
	pattern.spawner.simple_spawn(args)
	
	index += 1
	if index >= patterns.size(): index = 0
	
	patternTimer.start(patterns[index].timer)


func pattern_timer_timeout():
	call_pattern()
