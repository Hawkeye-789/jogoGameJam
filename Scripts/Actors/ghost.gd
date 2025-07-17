extends CharacterBody2D

@export var movement_speed : float
@onready var line_of_sight := $"Line of Sight" as RayCast2D
@onready var sight_area := $"Sight Area/Collision" as CollisionShape2D

var player_target : CharacterBody2D
var direction : Vector2
var player_position : Vector2
var player_is_nearby: bool = false

func _physics_process(delta: float) -> void:
	direction = player_position.normalized()
	velocity = direction * movement_speed
	
	if player_is_nearby:
		player_position = player_target.global_position - global_position
		line_of_sight.target_position = player_position
		if line_of_sight.get_collider() == player_target:
			move_and_slide()

func _player_entered_sight_area(player: Node2D) -> void:
	player_target = player
	player_is_nearby = true

func _player_exited_sight_area() -> void:
	player_is_nearby = false
