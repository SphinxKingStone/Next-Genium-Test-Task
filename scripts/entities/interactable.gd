class_name Interactable
extends Node2D

@export var unique_text: String

var has_player_near: bool = false

func _process(delta) -> void:
	if Input.is_action_just_pressed("interact") and has_player_near:
		UI.new_interactive_text(unique_text)

func _on_area_2d_area_entered(area: Area2D) -> void:
	has_player_near = true
	$Label.visible = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	has_player_near = false
	$Label.visible = false
