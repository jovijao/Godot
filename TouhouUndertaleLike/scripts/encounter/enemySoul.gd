extends CharacterBody2D

signal hurt(damage)

@onready var animationPlayer = $AnimationPlayer

var invincibleTime = 0.05
@onready var invincibleTimer = $Timer
var invicible = false

var team = "enemy"

var state = 0

func _on_hurtbox_body_entered(body):
	if body.team == team or invicible: return false
	if state != 0: return false
	hurt.emit(body.damage)
	
	invincibleTimer.start(invincibleTime)
	animationPlayer.play("hurt")
	invicible = true
	return true

func _on_timer_timeout():
	invicible = false
	animationPlayer.play("default")
