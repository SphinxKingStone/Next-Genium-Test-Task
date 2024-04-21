class_name Interior
extends Node2D


#func _ready() -> void:
	#get_tree().get_root().get_child(1).get_node("Player").position = $PlayerSpawnPoint.position
	#get_tree().get_root().get_child(1).get_node("Player")move_child(child_ref, 0)
	#player.position = $PlayerSpawnPoint.position

func _on_area_2d_body_entered(body) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://scenes/game.tscn")
