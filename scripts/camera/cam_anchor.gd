extends Node3D

@export var rotation_speed = 1.

var target_rotation = .0

func _input(event: InputEvent) -> void:
	if event.is_action("rot_left"):
		target_rotation -= deg_to_rad(45)
	if event.is_action("rot_right"):
		target_rotation += deg_to_rad(45)

func _process(delta):
	rotation.y = lerp_angle(rotation.y, target_rotation, rotation_speed * delta)
