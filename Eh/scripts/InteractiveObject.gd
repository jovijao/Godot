class_name InteractiveObject extends PhysicsBody2D


func interact(body = null):
#	print(body.name + " is interacting with " + self.name)
	for event in get_events(): if not event.event(body): return false
	return true


func get_events():
	var events = []
	for child in get_children():
		if child is Event: events.append(child)
	return events
