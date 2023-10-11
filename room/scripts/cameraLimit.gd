extends Marker2D

func _ready():
	var camera : Camera = get_tree().get_first_node_in_group("CAMERA")
	
	camera.limit_bottom = position.y
	camera.limit_right = position.x
