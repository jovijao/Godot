extends CanvasLayer


func add_screen(screen):
	var newScreen = ResourceManager.get_screen(screen)
	
	if newScreen == null: return null
	
	add_child(newScreen)
	return newScreen
