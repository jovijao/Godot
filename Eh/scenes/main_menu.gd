extends Control

func _ready():
	$CenterContainer/Panel/MarginContainer/VBoxContainer/PlayButton.grab_focus()

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
