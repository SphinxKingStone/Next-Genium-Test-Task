extends Node2D

signal player_entered

@export var interior: PackedScene

# instantiate interior upon enetring house 
func _on_entrance_hitbox_body_entered(body) -> void:
	if body.name == "Player":
		# Instantiates scene
		var scene = interior.instantiate()
		
		# remove street scene and add interior scene
		get_tree().get_root().get_child(1).get_child(0).queue_free()
		#get_tree().get_root().get_child(1).add_child(scene)
		get_tree().get_root().get_child(1).call_deferred("add_child", scene)
		await get_tree().process_frame 
		await get_tree().process_frame 
		await get_tree().process_frame 
		await get_tree().process_frame 
		get_tree().get_root().get_child(1).move_child(scene, 0)
