extends CharacterBody2D


var speed: int = 100
var movement_state: String = "idle"
var facing: String = "up"
var max_hp: int = 10
var hp: int = 5
var keys: int = 0
var last_visited_house: String = ""


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

func add_key() -> void:
	self.keys += 1
	UI.update_keys_label(self.keys)

func use_key() -> bool:
	if self.keys > 0:
		self.keys -= 1
		UI.update_keys_label(self.keys)
		return true
	return false

func change_max_hp(amount: int) -> void:
	self.max_hp += amount
	update_hp()

func change_hp(amount: int) -> void:
	self.hp += amount
	update_hp()

func update_hp() -> void:
	# prevent having more hp than you can
	self.hp = min(self.hp, self.max_hp)
	
	# game over
	if self.hp <= 0:
		UI.death()
	
	UI.update_hp_label(self.hp, self.max_hp)
