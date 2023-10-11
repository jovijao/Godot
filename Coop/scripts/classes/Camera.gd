class_name Camera extends Camera2D


@export var followingNodes : Array[Node]

func _physics_process(delta):
	
	var newPos = Vector2.ZERO
	var distance = 0.0
	
	for node in followingNodes:
		newPos += node.global_position
		var nodeDistance = global_position.distance_to(node.global_position)
		
		if nodeDistance > distance: distance = nodeDistance
	
	newPos /= followingNodes.size()
	
	
	global_position = lerp(global_position, newPos, 16 * delta)
	var newZoom = Vector2(1, 1) - Vector2(distance, distance)/64 + Vector2(0.2, 0.2)
	newZoom = clamp(newZoom, Vector2(0.2, 0.2), Vector2(5, 5))
	
	zoom = lerp(zoom, Vector2(1, 1) - Vector2(distance, distance)/384 + Vector2(0.2, 0.2) , delta)
	
	
	
