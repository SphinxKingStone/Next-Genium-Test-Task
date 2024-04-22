class_name Interior
extends Node2D


func _ready() -> void:
	Player.position = $PlayerSpawnPoint.position

func _on_area_2d_body_entered(body) -> void:
	if body.name == "Player":
		for ch in get_tree().get_root().get_children():
			if ch is Game:
				ch.save_interior_state()
				ch.change_scene()
