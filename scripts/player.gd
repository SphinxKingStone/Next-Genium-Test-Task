extends CharacterBody2D

var speed = 100

var movement_state = "idle"

func _physics_process(delta) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		movement_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		movement_state = "moving"
	velocity = direction * speed
	move_and_slide()
	update_movement_animation(direction)
	

func update_movement_animation(direction: Vector2) -> void:
	var facing: String
	var state: String
	
	if movement_state == "moving":
		state = "move"
	else:
		state = "idle"
	
	if direction.y == -1:
		facing = "up"
	if direction.y == 1:
		facing = "down"
	if direction.x == -1:
		facing = "left"
	if direction.x == 1:
		facing = "right"
	
	$animation.play(state + "_" + facing)
