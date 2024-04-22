class_name Game
extends Node2D

var street_state: Dictionary
var interior_state: Dictionary

func _ready() -> void:
	save_street_state()
	connect_collectable_signal()

func save_street_state() -> void:
	if not self.has_node("Street"):
		return
	for ch in $Street.get_children():
		# save House lock status
		if ch is House:
			street_state[ch.name] = ch.locked
		
		# save collectable item collected status
		if ch is Collectable:
			street_state[ch.name] = ch.is_collected

func save_interior_state() -> void:
	# save is_collected data by last_visited_house key
	if Player.last_visited_house != "":
		interior_state[Player.last_visited_house] = []
		for ch in $Interior.get_children():
			if ch is Collectable:
				interior_state[Player.last_visited_house].append(ch.is_collected)

func load_interior_state() -> void:
	# wait for the scene to change
	while not self.has_node("Interior"):
		await get_tree().process_frame
	
	# check if we have any info on this house interior state
	if not interior_state.has(Player.last_visited_house):
		return
	
	var counter: int = 0
	for ch in $Interior.get_children():
		if ch is Collectable:
			if interior_state[Player.last_visited_house].is_empty():
				# this means there are no collectable items left so no data on them
				ch.collect_item()
			elif interior_state[Player.last_visited_house][counter]: 
				# regular check if item has been collected
				ch.collect_item()
				counter += 1

func load_street_state() -> void:
	# wait for the scene to change
	while not self.has_node("Street"):
		await get_tree().process_frame
	
	# load street state back
	for ch in $Street.get_children():
		if ch is House:
			ch.lock_door(street_state[ch.name])
			if ch.name == Player.last_visited_house:
				Player.position = ch.position - Vector2(0, -20)
		if ch is Collectable:
			if street_state[ch.name]:
				ch.collect_item()
	connect_collectable_signal()

func change_scene(new_scene = null) -> void:
	save_street_state()
	if new_scene is Interior:
		# remove street scene and add interior scene from main Game scene
		for ch in get_tree().get_root().get_children():
			if ch is Game:
				ch.get_child(0).queue_free()
				ch.call_deferred("add_child", new_scene)
				load_interior_state()
				return
	
	# if not new_scene it means it's not an Interior thus it's the street
	if not new_scene:
		self.get_child(0).queue_free()
		self.call_deferred("add_child", load("res://scenes/locations/street.tscn").instantiate())
		load_street_state()

func connect_collectable_signal() -> void:
	for ch in $Street.get_children():
		if ch is Collectable:
			ch.item_collected.connect(self.save_street_state)

func lock_everything() -> void:
	if not self.has_node("Street"):
		return
	for ch in $Street.get_children():
		if ch is House:
			ch.lock_door(true)
