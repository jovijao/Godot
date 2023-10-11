extends Node

var INSTANCES = {
	"bulletTrail": preload("res://instances/gun_trail.tscn"),
	"gunShot": preload("res://instances/gun_shot.tscn")
}

func get_instance(instance):
	if not instance in INSTANCES: return null
	return INSTANCES[instance].instantiate()
