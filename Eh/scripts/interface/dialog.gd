extends Control

signal timeline_finished

signal index_changed
signal text_changed

@onready var textBox : RichTextLabel = $Panel/MarginContainer/RichTextLabel

var timeline = {"settings": {}, "dialogs": []}

var index = 0

var showingText = false

var textSpeed = 32.0
var shownText = 0.0

func _ready():
	update_index()

func _process(delta):
	if showingText:
		shownText += textSpeed * delta
		textBox.visible_characters = round(shownText)
		
		if textBox.text.length() < shownText: 
			showingText = false


func update_index():
	if index >= timeline.dialogs.size(): 
		timeline_finished.emit()
		return
	
	var dialog = timeline.dialogs[index]
	
	for key in dialog:
		var info = dialog[key]
		match key:
			"text": set_text(info) 


func set_text(text):
	textBox.text = text
	text_changed.emit()
	
	shownText = 0.0 
	textBox.visible_characters = 0
	
	showingText = true



func next():
	if showingText:
		shownText = textBox.text.length()
		return
	index += 1
	index_changed.emit()
	
	update_index()


func set_timeline(newTimeline):
	index = 0
	timeline = newTimeline
	
	update_index()

func _input(event):
	if event.is_pressed():
		if Input.is_action_just_pressed("ui_accept"): next()
