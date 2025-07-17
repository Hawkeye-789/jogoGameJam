extends CharacterBody2D

@export var movement_speed : float
@export var running_speed_boost : float

@onready var player_vision: Area2D = $"Player Vision"

var character_direction : Vector2
var running : bool = false

func _physics_process(delta: float) -> void:
	character_direction.x = Input.get_axis("left", "right")
	character_direction.y = Input.get_axis("up", "down")
	character_direction = character_direction.normalized()
	running = Input.is_action_pressed("run")
	
	if character_direction:
		velocity = character_direction * movement_speed
		if running:
			velocity *= running_speed_boost
		player_vision.rotation = character_direction.angle() - PI / 2
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		
	move_and_slide()
	
