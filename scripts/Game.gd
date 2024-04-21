class_name Game
extends Node2D

var street_state: Dictionary

func _ready() -> void:
	save_street_state()
	connect_collectable_signal()

func save_street_state() -> void:
	for ch in $Street.get_children():
		# save House lock status
		if ch is House:
			street_state[ch.name] = ch.locked
		
		# save collectable item collected status
		if ch is Collectable:
			street_state[ch.name] = ch.is_collected

func load_street_state() -> void:
	# wait for the scene to change
	while not $Street:
		await get_tree().process_frame
	
	# load street state back
	for ch in $Street.get_children():
		if ch is House:
			ch.lock_door(street_state[ch.name])
		if ch is Collectable:
			if street_state[ch.name]:
				ch.collect_item()
	connect_collectable_signal()

func change_scene(new_scene = null) -> void:
	if new_scene is Interior:
		# remove street scene and add interior scene from main Game scene
		for ch in get_tree().get_root().get_children():
			if ch is Game:
				ch.get_child(0).queue_free()
				ch.call_deferred("add_child", new_scene)
				return
	if not new_scene:
		self.get_child(0).queue_free()
		self.call_deferred("add_child", load("res://scenes/locations/street.tscn").instantiate())
		load_street_state()

func connect_collectable_signal() -> void:
	for ch in $Street.get_children():
		if ch is Collectable:
			ch.item_collected.connect(self.save_street_state)
