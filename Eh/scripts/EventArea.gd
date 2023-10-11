class_name EventArea extends Area2D

@export var onlyPlayer = true

func entered(body = null):
	if onlyPlayer: if body.name != "Player": return false
	print(body.name + " entered " + self.name)
	
	for event in get_events(): if not event.event(body): return false
	return true


func get_events():
	var events = []
	for child in get_children():
		if child is Event: events.append(child)
	return events


func _ready():
	body_entered.connect(entered)
