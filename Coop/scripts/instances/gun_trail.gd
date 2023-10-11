extends Line2D

var decreaseFactor = 6.0

func draw_trail(start : Vector2, end : Vector2):
	add_point(start)
	add_point(end)


func _physics_process(delta):
	width -= delta * decreaseFactor


func _on_timer_timeout():
	queue_free()
