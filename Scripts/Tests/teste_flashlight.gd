extends PointLight2D

var speed := 100
var velocity : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("interact"):
		rotation_degrees += rad_to_deg(PI / 2)
	
	var hdir
	var vdir
	
	velocity = Vector2.ZERO
	
	hdir = Input.get_axis("left", "right")
	vdir = Input.get_axis("up", "down")
	
	velocity = Vector2(hdir * speed * delta, vdir * speed * delta)
	
	position += velocity
