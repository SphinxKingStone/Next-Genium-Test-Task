class_name Collectable
extends Node2D

signal item_collected

@export var item_code: String
@export var is_collected: bool = false

func _ready() -> void:
	update_item()

# setup an item by building them from Collectables via exported item_code
func update_item() -> void:
	for i in Collectables.items.values():
		if i.code == item_code:
			$Sprite2D.texture = i.icon
			$CollectionHitbox/CollisionShape2D.shape.radius = max($Sprite2D.texture.get_width()/2, $Sprite2D.texture.get_height()/2)
			return

func _on_collection_hitbox_body_entered(body) -> void:
	if body.name == "Player":
		if item_code == "key":
			Player.add_key()
	collect_item()

# removes item
func collect_item() -> void:
	is_collected = true
	emit_signal("item_collected")
	self.queue_free()
