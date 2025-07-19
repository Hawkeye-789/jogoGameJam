extends CharacterBody2D

@export var movement_speed : float
@export var running_speed_boost : float

@onready var player_vision: Area2D = $"Player Vision"
@onready var player_sound: CollisionShape2D = $"Player Sound/Collision"

var character_direction : Vector2
var running : bool = false

func _physics_process(_delta: float) -> void:
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

	if velocity.length() == 0:
		player_sound.scale = Vector2(1, 1)
	elif velocity.length() >= movement_speed * running_speed_boost * 0.9:
		player_sound.scale = Vector2(10, 10)
	else:
		player_sound.scale = Vector2(5, 5)
		
	move_and_slide()
	
func _on_vision_enemy_entered(enemy: Node2D) -> void:
	if enemy.has_method("_on_spotted_by_player"):
		enemy._on_spotted_by_player()
	#enemy.emit_signal("spotted_by_player")

func _on_vision_enemy_exited(enemy: Node2D) -> void:
	if enemy.has_method("_on_despotted_by_player"):
		enemy._on_despotted_by_player()
	#enemy.emit_signal("despotted_by_player")

func _on_sound_enemy_entered(enemy: Node2D) -> void:
	if enemy.has_method("heard_player_now"):
		enemy.heard_player_now()

func _on_sound_enemy_exited(enemy: Node2D) -> void:
	if enemy.has_method("didn_hear_player"):
		enemy.didn_hear_player()
