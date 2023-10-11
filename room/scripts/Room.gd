class_name Room extends Control

signal room_is_ready

func _ready():
	room_is_ready.emit()
