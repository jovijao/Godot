extends Sprite2D

signal pressed(x, y)

var x : int = 0
var y : int = 0

func _on_button_pressed():
	pressed.emit(x, y)
