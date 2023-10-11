extends CharacterBody2D

@onready var itemHandle = $ItemHandle
@onready var item = itemHandle.get_node("Item")

@onready var healthBar = $HealthBar

@onready var itemCooldownTimer = $ItemCooldownTimer

@export var player = 0

var speed = 80.0
var direction = Vector2(randi_range(-1, 1), randi_range(-1, 1)).normalized()


enum {
	IDLE,
	FREE,
	GUN,
	SHOT
}

var state = FREE

func _physics_process(delta):
	match state:
		FREE:
			var inputVector = PlayerInput.get_vector(player)
			velocity = lerp(velocity, inputVector * speed, 16.0 * delta )
			move_and_slide()
			
			if inputVector != Vector2.ZERO: 
				direction = inputVector
				aim_item(direction, delta, 12)
			
			if PlayerInput.is_action_pressed(player, "use"): 
				if itemCooldownTimer.is_stopped(): state = GUN
			
		GUN:
			velocity = lerp(velocity, Vector2.ZERO, 8.0 * delta )
			move_and_slide()
			
			if PlayerInput.get_vector(player) != Vector2.ZERO: 
				direction = PlayerInput.get_vector(player)
				aim_item(direction, delta)
			
			if PlayerInput.is_action_just_released(player, "use"): 
				var gunShot = ResourceManager.get_instance("gunShot")
				get_parent().add_child(gunShot)
				gunShot.set_direction(Vector2(1, 0).rotated(itemHandle.rotation)).set_quantity(1).set_spread(2).execute(item.global_position)
				
				itemCooldownTimer.start(0.4)
				state = FREE


func aim_item(dir, delta, factor = 6):
	var lastRotation = itemHandle.rotation
	itemHandle.look_at(position + direction)
	var newRotation = itemHandle.rotation
	
	itemHandle.rotation = lerp(lastRotation, newRotation, delta * factor)
	
	item.flip_v = direction.x < 0


func _on_hurtbox_hurt(damage, dir):
	healthBar.value -= damage
	if healthBar.value <= 0:
		healthBar.value = 5
		
		global_position = Vector2(randi_range(16, 384-16), randi_range(16, 216-16))
	
	
	velocity = -dir * 80
	move_and_slide()
