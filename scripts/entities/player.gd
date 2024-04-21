extends CharacterBody2D


var speed: int = 100
var movement_state: String = "idle"
var facing: String = "up"
var max_health: int = 10
var health: int = 10
var keys: int = 0

@onready var keys_label 

func _physics_process(delta) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")

	if direction.x == 0 and direction.y == 0:
		movement_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		movement_state = "moving"
	update_movement_animation(direction)
	
	velocity = direction * speed
	move_and_slide()

func update_movement_animation(direction: Vector2) -> void:
	var state: String
	
	if movement_state == "moving":
		state = "move"
	else:
		state = "idle"
	
	if direction.y <= -0.5:
		facing = "up"
	if direction.y >= 0.5:
		facing = "down"
	if direction.x <= -0.5:
		facing = "left"
	if direction.x >= 0.5:
		facing = "right"
	
	$Animation.play(state + "_" + facing)
