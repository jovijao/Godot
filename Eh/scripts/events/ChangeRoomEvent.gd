extends Event

@export var room = ""
var timer = Timer.new()

func _ready():
	add_child(timer)
	timer.timeout.connect(change_room)


func event(body = null):
	body.canMove = false
	timer.start()
	
	
	Interface.add_child(ResourceManager.get_instance("darknessFade"))
	return true

func change_room():
	Interface.add_child(ResourceManager.get_instance("darknessUnfade"))
	Game.change_room(room)
