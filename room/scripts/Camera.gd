class_name Camera extends Camera2D


var speed = 80
var velocity = Vector2.ZERO

@export var movDistance = 80

func _init():
	limit_left = 0
	limit_top = 0;

func _ready():
	for c in get_tree().get_nodes_in_group("CAMERA"): c.queue_free()
	add_to_group("CAMERA")
	
	enabled = true


func _physics_process(delta):
	
	var camPos = position
	var mousePos = (get_global_mouse_position() - Vector2(316, 216)/2)
	
	print(camPos - mousePos)
	print(mousePos.distance_to(camPos))
	
	if mousePos.distance_to(camPos) > movDistance:
		print("ah")
		velocity = lerp(velocity, (mousePos - camPos).normalized() * speed, 20 * delta)
	else:
		velocity = lerp(velocity, Vector2.ZERO, 20 * delta)
	
	print(velocity)
	position += velocity * delta
