class_name House
extends Node2D

signal player_entered

@export var interior: PackedScene
@export var locked: bool = true

# instantiate interior upon enetring house 
func _on_entrance_hitbox_body_entered(body) -> void:
	if not interior:
		return
	if body.name == "Player":
		if not locked or (locked and Player.use_key()):
			lock_door(false)
		else:
			return
		Player.last_visited_house = self.name
		for ch in get_tree().get_root().get_children():
			if ch is Game:
				ch.change_scene(interior.instantiate())

func lock_door(lock: bool) -> void:
	self.locked = lock
	$Lock.visible = lock
