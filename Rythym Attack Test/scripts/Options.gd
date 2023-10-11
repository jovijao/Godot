extends CenterContainer

signal fight_pressed
signal skill_pressed
signal item_pressed
signal defend_pressed
signal wait_pressed


func _ready():
	get_node("PanelContainer/MarginContainer/VBoxContainer").get_child(0).grab_focus()


func _on_fight_button_pressed():
	fight_pressed.emit()

func _on_skill_button_pressed():
	skill_pressed.emit()

func _on_item_button_pressed():
	item_pressed.emit()

func _on_defend_button_pressed():
	defend_pressed.emit()

func _on_wait_button_pressed():
	wait_pressed.emit()
