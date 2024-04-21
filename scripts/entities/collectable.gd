extends Node2D

@export var item_name: String
@export var texture: Texture2D

func _ready():
	$CollectionHitbox/CollisionShape2D.shape.radius = max(texture.get_width(), texture.get_height())

func _on_collection_hitbox_body_entered(body):
	print_debug(item_name)
