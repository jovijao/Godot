extends Node2D

@onready var line = $Line

var duration = 0.10
var state = 0

@onready var start_point = global_position

func _ready():
	line.add_point(start_point + Vector2(0, -8))

func _process(delta):
	match state:
		0:
			line.points[1] = start_point - global_position + Vector2(0, -8)
			if duration <= 0.03: state = 1
		1: 
			line.width -= delta * 100
			if duration <= -0.5: queue_free()
	
	duration -= delta
