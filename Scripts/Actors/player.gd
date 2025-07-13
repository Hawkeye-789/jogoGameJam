extends CharacterBody2D

@export var movement_speed : float 
var character_direction : Vector2

func _physics_process(delta: float) -> void:
	character_direction.x = Input.get_axis("left", "right")
	character_direction.y = Input.get_axis("up", "down")
	character_direction = character_direction.normalized()
	
	if character_direction:
		velocity = character_direction * movement_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)	
		
	move_and_slide()
	
