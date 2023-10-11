extends Area2D


func _on_body_entered(_body):
	Game.change_to_encounter()
