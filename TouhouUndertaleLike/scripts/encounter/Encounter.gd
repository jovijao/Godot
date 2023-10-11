class_name Encounter extends Control

@export var interfaceHandler : CanvasLayer
@onready var interface = interfaceHandler.get_child(0)

@export var arena : Node2D
@onready var projectiles = arena.projectiles


var soul = null
var player = {
	"health": 20,
	"maxHealth": 20
}


var state = 0

static func get_projectiles():
	return Game.get_encounter().projectiles


func _ready():
	interface.skill_pressed.connect(skill_pressed)
	interface.defend_pressed.connect(skill_pressed)
	interface.item_pressed.connect(skill_pressed)
	
	round_finished()


func skill_pressed():
	start_round()

func defend_pressed():
	start_round()

func item_pressed():
	start_round()


func start_round():
	interface.roundBar.hide()
	interface.healthBar.show()
	
	soul = arena.start_round()
	soul.hurt.connect(player_hurt)
	
	
	arena.attacks.add_child(load("res://instances/encounter/projectile_patterns.tscn").instantiate())

func round_finished():
	interface.roundBar.show()
	interface.healthBar.hide()


func player_hurt(damage):
	player.health = player.health - damage
	interface.set_health_bar(player.health)
	
	if player.health <= 0: call_death()


func call_death():
	soul.state = -1
	soul.hide()
	
	var timer = Timer.new()
	add_child(timer)
	timer.start(0.6)
	timer.timeout.connect(call_death_screen)


func call_death_screen():
	get_tree().change_scene_to_file("res://scenes/menus/game_over_screen.tscn")

static func get_soul():
	return Game.get_encounter().soul
