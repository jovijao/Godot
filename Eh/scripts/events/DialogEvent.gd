extends Event

@export var timeline = ""


func event(body = null):
	body.change_state(-1)
	
	var dialog = Interface.add_screen("dialog")
	dialog.timeline_finished.connect(timeline_finished.bind(body, dialog))
	dialog.set_timeline(ResourceManager.get_timeline(timeline))
	
	return true


func timeline_finished(body, screen):
	body.change_state(0)
	body.interactTimer.start()
	
	screen.queue_free()
