extends CPUParticles2D

signal lifetime_timeout

@export var deleteOnFinish = true
@export var lifetimeTimer = true

@export var emitOnReady = true

func _ready():
	emitting = emitOnReady
	
	if lifetimeTimer:
		var timer = Timer.new()
		add_child(timer)
		
		timer.start(lifetime)
		timer.timeout.connect(_on_lifetime_timeout)



func _on_lifetime_timeout():
	if deleteOnFinish: queue_free()
	
	
	lifetime_timeout.emit()
