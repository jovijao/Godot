extends CenterContainer

signal attack_finished(attack)

@onready var cursor = $Background/Cursor


var CURSOREFFECT = preload("res://instances/hit_effect.tscn")

var bpm = 70


var attacks = {
	"busterPunches": [1, 3, 5, 7],
	"surprise": [0, 7],
}


var attackData = {
	"busterPunches": { "damage": 40 },
	"surprise": { "damage": 12, "effect": "stun" }
}


var currentAttack = []
var lastPressed = 0

var cursorPos = 0.0


func _physics_process(delta):
	cursorPos += delta * bpm
	cursor.position.x = cursorPos
	
	if cursorPos > 16 * 9: 
		attack_finished.emit(check_attack())
		set_physics_process(false)
		
		reset()
		return
	
	
	if Input.is_action_just_pressed("interact"):
		var attackCheck = round(cursorPos/16) * 16
		if attackCheck  < 8 or attackCheck > 16 * 8.2: return
		if currentAttack.size() > 0 and currentAttack[currentAttack.size() - 1] == (attackCheck/16 - 1): return 
		
		lastPressed = attackCheck
		currentAttack.append(lastPressed/16 - 1)
		
		var effect = CURSOREFFECT.instantiate()
		effect.global_position = global_position + Vector2(lastPressed, cursor.size.y/2)
		cursor.get_parent().add_child(effect) 


func check_attack(attack = currentAttack):
	for a in attacks:
		if str(attacks[a]) == str(attack): 
			return a
	return ""


func reset():
	currentAttack = []
	
	cursorPos = 0
	cursor.position.x = cursorPos
	
	set_physics_process(true)
