extends Control

signal skill_pressed
signal defend_pressed
signal item_pressed


@onready var healthBarHandle = $CenterContainer2
@onready var healthBar = $CenterContainer2/HealthBar

@onready var roundBar = $CenterContainer/Panel


func set_health_bar(health):
	healthBar.value = health


func _on_skill_button_pressed():
	skill_pressed.emit()


func _on_defend_button_pressed():
	defend_pressed.emit()


func _on_item_button_pressed():
	item_pressed.emit()
